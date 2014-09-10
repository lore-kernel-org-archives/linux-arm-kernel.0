From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 10 Sep 2014 09:52:01 +0800
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Configure the pins locally
In-Reply-To: <1409921170-23935-1-git-send-email-festevam@gmail.com>
References: <1409921170-23935-1-git-send-email-festevam@gmail.com>
Message-ID: <20140910015159.GE2341@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 09:46:10AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Passing '0x80000000' to the pin configuration means that kernel will skip the
> IOMUXC_SW_PAD_CTL configuration and will use whathever values come from the 
> bootloader.
> 
> Instead of relying on the bootloader setup, let's configure it in the kernel to
> have predictable settings.
> 
> '0x1b0b0' is the default POR value for all these pins and has also been verified
> that the pins are using this value by manually inspecting the IOMUXC_SW_PAD_CTL
> registers, so no functional change has been made.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
