From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Mar 2015 12:40:16 +0800
Subject: [PATCH] ARM: dts: imx: Add dr_mode host setting to all host-only
 usb instances
In-Reply-To: <1425045960-14191-1-git-send-email-mporter@konsulko.com>
References: <1425045960-14191-1-git-send-email-mporter@konsulko.com>
Message-ID: <20150306044014.GQ20455@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 09:06:00AM -0500, Matt Porter wrote:
> The chipidea driver adds an extra line of spam to the log when a
> host-only chipidea instance is left set to the default of a dual role
> controller.
> 
> [    2.010873] ci_hdrc ci_hdrc.1: doesn't support gadget
> 
> Set the dr_mode property to host on all the host-only nodes
> to avoid this warning.
> 
> Signed-off-by: Matt Porter <mporter@konsulko.com>

Applied, thanks.
