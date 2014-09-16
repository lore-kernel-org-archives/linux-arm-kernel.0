From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Sep 2014 17:10:01 +0100
Subject: [PATCH] arm: Remove redundant config value DEBUG_UART_NETX
In-Reply-To: <541764E9.5030308@linaro.org>
References: <1410818986-13273-1-git-send-email-daniel.thompson@linaro.org>
 <541764E9.5030308@linaro.org>
Message-ID: <20140916161001.GL12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 11:15:05PM +0100, Daniel Thompson wrote:
> On 15/09/14 23:09, Daniel Thompson wrote:
> > Commit 880fa9b6fd73 ("ARM: 8144/1: netx: Migrate DEBUG_LL macros to
> > shared directory") spuriously introduces an unused config variable,
> > DEBUG_UART_NETX. Let's remove it.
> 
> Not sure if this is better shared as a new patch (as below) or respun
> from the original (as 8144/2)?

Oh, it's a patch I have... in which case, please respin this patch, and
throw the updated patch into the patch system.  Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
