From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 5 Aug 2015 22:08:14 +0800
Subject: [PATCH v2 00/10] USB: chipidea misc patches
In-Reply-To: <1438577238-10153-1-git-send-email-peter.chen@freescale.com>
References: <1438577238-10153-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20150805140813.GO12927@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 12:47:08PM +0800, Peter Chen wrote:
> Hi all,
> 
> In this series, I add several new interfaces for chipidea driver,
> they are mainly for system configuration adjustment. The USB
> performance may be improved with these configuration changing,
> but each vendor driver owner needs to consult with your IC
> owner which configuration parameters are suitable for your system
> before changing it, and only change it if necessary.
> 
> The other changes are for imx, it shows how imx uses these interfaces.
> Shawn, the patch [5/10] and [9/10] are dts changes, help to review it
> please.

Ping me, after driver and bindings are accepted.  Then I will pick up
the dts changes.

Shawn
