# !/usr/bin/env bash
token=					# add telegram token
chat_id=				# add chat id
TANGGAL=$(date +"%Y-%m-%d-%H:%M")
BUILDS_DIR=/root/kernel-builds

# Zipping
zipping() {
	echo "lets make flashable kernel zip "

	cp -n out/arch/arm64/boot/Image.gz-dtb AnyKernel3
	cp -n out/arch/arm64/boot/dtbo.img AnyKernel3

    	cd AnyKernel3
    	zip -r9 LordKurama-Kernel-R5x-TESTBUILD-${TANGGAL}.zip *
	echo -e "done zipping..... \n"
}

#uploading
uploading() {
	cd ${BUILDS_DIR}

	echo -e "so finally time to upload kernel to tg \n"
	ZIP=$(pwd)/LordKurama-Kernel-R5x-TESTBUILD-${TANGGAL}.zip
	curl -F document=@$ZIP "https://api.telegram.org/bot$token/sendDocument" \
		-F chat_id="$chat_id" \
 		-F "disable_web_page_preview=true" \
		-F "parse_mode=html"
	echo -e "\nuploading done.."
	cd $KERNEL_DIR
}

#saving
saving() {
	echo -e "lets save flashable zip tp somewhere else \n"
	#cd AnyKernel || exit 1
	cp -n LordKurama-Kernel-R5x-TESTBUILD*.zip ${BUILDS_DIR}
	echo -e "saving done.... \n"
}

#cleaning
cleaning() {
	echo -e "cleaning anykernel dir for next builds \n"
	rm -rf LordKurama-Kernel-R5x-TESTBUILD*.zip
	echo -e "cleaning done.... \n"
}


zipping
saving
cleaning
uploading
