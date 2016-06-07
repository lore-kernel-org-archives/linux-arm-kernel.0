From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Tue, 7 Jun 2016 11:22:35 -0300
Subject: [PATCH v3 0/9] Add MT8173 Video Decoder Driver
In-Reply-To: <1464611363-14936-1-git-send-email-tiffany.lin@mediatek.com>
References: <1464611363-14936-1-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <20160607112235.475c2e4c@recife.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Mon, 30 May 2016 20:29:14 +0800
Tiffany Lin <tiffany.lin@mediatek.com> escreveu:

> ==============
>  Introduction
> ==============
> 
> The purpose of this series is to add the driver for video codec hw embedded in the Mediatek's MT8173 SoCs.
> Mediatek Video Codec is able to handle video decoding of in a range of formats.
> 
> This patch series add Mediatek block format V4L2_PIX_FMT_MT21, the decoder driver will decoded bitstream to
> V4L2_PIX_FMT_MT21 format.
> 
> This patch series rely on MTK VPU driver in patch series "Add MT8173 Video Encoder Driver and VPU Driver"[1]
> and patch "CHROMIUM: v4l: Add V4L2_PIX_FMT_VP9 definition"[2] for VP9 support.
> Mediatek Video Decoder driver rely on VPU driver to load, communicate with VPU.
> 
> Internally the driver uses videobuf2 framework and MTK IOMMU and MTK SMI both have been merged in v4.6-rc1.
> 
> [1]https://patchwork.linuxtv.org/patch/33734/
> [2]https://chromium-review.googlesource.com/#/c/245241/

Hmm... I'm not seeing the firmware for this driver at the
linux-firmware tree:
	https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/log/

Nor I'm seeing any pull request for them. Did you send it?
I'll only merge the driver upstream after seeing such pull request.

Regards,
Mauro
