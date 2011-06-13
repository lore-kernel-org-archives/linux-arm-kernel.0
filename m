From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 13 Jun 2011 09:36:45 -0300
Subject: [PATCH 5/6] ARM: mxc: all three imx51 TOs use TO1 version of sdma
	script
In-Reply-To: <1307950645-26529-6-git-send-email-shawn.guo@linaro.org>
References: <1307950645-26529-1-git-send-email-shawn.guo@linaro.org>
	<1307950645-26529-6-git-send-email-shawn.guo@linaro.org>
Message-ID: <BANLkTimAUDZ+H5Q_NuvWEna=XvOgFoTq5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, Jun 13, 2011 at 4:37 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Though there are three TOs of imx51 soc, the sdma script never
> changes since TO1, which means all three TOs of imx51 uses TO1
> version of sdma script.
>
> The current code passes TO number to imx-sdma driver to load
> different firmware for different TO. ?That means we have to prepare
> 3 identical firmwares, sdma-imx25-to1.bin sdma-imx25-to2.bin and
> sdma-imx25-to3.bin,

I think you want to mean:
sdma-imx51-to1.bin, sdma-imx51-to2.bin, sdma-imx51-to3.bin

Please fix the commit log.

Regards,

Fabio Estevam
