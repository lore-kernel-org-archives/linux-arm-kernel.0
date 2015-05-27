From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 May 2015 11:06:37 +0800
Subject: [PATCH 0/2] ARM: dts: add Okaya LCD display for Nitrogen and
 Sabrelite
In-Reply-To: <1432314867-30888-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1432314867-30888-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <20150527030636.GB16165@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 07:14:25PM +0200, Gary Bisson wrote:
> This series adds the Okaya 7" LCD display that is a WVGA (800x480) panel with
> a 18-bit parallel interface for both Nitrogen and Sabrelite.
> 
> A U-Boot script to configure the displays based on detection of the
> touch controller is available for reference here:
> https://github.com/boundarydevices/u-boot-imx6/blob/staging/board/boundary/nitrogen6x/6x_bootscript-mainline.txt
> 
> Gary Bisson (2):
>   ARM: dts: imx6qdl-nitrogen6x: add Okaya LCD display
>   ARM: dts: imx6qdl-sabrelite: add Okaya LCD display

Philipp,

Are you okay with these two patches?

Shawn
