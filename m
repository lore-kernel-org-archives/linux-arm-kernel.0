From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 11 Jul 2017 10:11:18 +0800
Subject: [PATCH v4 1/4] ARM: dts: imx6ul-geam-kit: Remove re-enabled usdhc1
In-Reply-To: <1497596680-3186-1-git-send-email-jteki@openedev.com>
References: <1497596680-3186-1-git-send-email-jteki@openedev.com>
Message-ID: <20170711021117.GC3172@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 16, 2017 at 12:34:37PM +0530, Jagan Teki wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> usdhc1 is enabled and assigned pinctrl-0 on imx6ul-geam.dtsi
> but same thing done on imx6ul-geam-kit.dts, so remove this
> re-enabled node from the same.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied all, thanks.
