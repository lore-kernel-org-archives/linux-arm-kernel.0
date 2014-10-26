From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 26 Oct 2014 08:23:55 +0800
Subject: [PATCHv6 0/6] ARM: imx: Add Freescale LS1021A SoC and board
 support
In-Reply-To: <1414145327-23541-1-git-send-email-jingchang.lu@freescale.com>
References: <1414145327-23541-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <20141026002354.GC6973@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 06:08:41PM +0800, Jingchang Lu wrote:
> This series contain the support for Freescale LS1021A CPU and LS1021A-QDS
> and LS1021A-TWR board.
> 
> The LS1021A SoC combines two ARM Cortex-A7 cores that have been optimized
> for high reliability and pack the highest level of integration available
> for sub-3W embedded communications processors and with a comprehensive
> enablement model focused on ease of programmability.
> 
> The LS1021A SoC shares IPs with i.MX family, Vybrid family and Freescale
> PowerPC platform. 
> 
> For the detail information about LS1021A SoC, please refer to the RM doc.
> 
> ---
> changes in v6:
>  add dts patch description.
>  remove '-' from QDS and TWR board dts name for consistence with u-boot.

I'm not sure it's a good idea.  The most idiomatic DTS naming schema is
just <socname>-<boardname>.dts.

Shawn
