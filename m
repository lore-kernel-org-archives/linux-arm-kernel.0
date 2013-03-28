From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 28 Mar 2013 13:33:35 -0400
Subject: [PATCH] arm: mvebu: Fix pinctrl for Armada 370 Mirabox SDIO port.
In-Reply-To: <1364340751-10585-1-git-send-email-ryan@presslab.us>
References: <1364340751-10585-1-git-send-email-ryan@presslab.us>
Message-ID: <20130328173335.GA13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 04:32:31PM -0700, Ryan Press wrote:
> The previous configuration used the wrong "clk" pin.  Without this
> change mv_sdio worked because the bootloader would set the pin up, but
> with a bootloader that does not set the pin, mv_sdio fails to detect
> any card.
> 
> I have tested this change using a mwifiex_sdio wireless network
> adapter over the SDIO interface.
> 
> Signed-off-by: Ryan Press <ryan@presslab.us>
> ---
>  arch/arm/boot/dts/armada-370-mirabox.dts | 2 +-
>  arch/arm/boot/dts/armada-370.dtsi        | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)

Applied to mvebu/fixes

I changed the commit message to wrap at the appropriate width.

thx,

Jason.
