From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Feb 2013 11:43:30 +0800
Subject: [PATCH] ARM: mxs_defconfig: Make USB host functional again
In-Reply-To: <1361984638-19725-1-git-send-email-festevam@gmail.com>
References: <1361984638-19725-1-git-send-email-festevam@gmail.com>
Message-ID: <20130228034328.GB26106@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 02:03:58PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> commit 09f6ffde2e (USB: EHCI: fix build error by making ChipIdea host a normal 
> EHCI driver) introduced CONFIG_USB_EHCI_HCD as a dependency for USB_CHIPIDEA_HOST.
> 
> Select CONFIG_USB_EHCI_HCD, so that USB host can be functional again.
> 
> Cc: <stable@vger.kernel.org> # 3.8
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
