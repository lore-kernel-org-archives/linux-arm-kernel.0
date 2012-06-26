From: socketcan@hartkopp.net (Oliver Hartkopp)
Date: Tue, 26 Jun 2012 18:55:29 +0200
Subject: [PATCH 0/2] flexcan driver updates
In-Reply-To: <1340700563-8386-1-git-send-email-shawn.guo@linaro.org>
References: <1340700563-8386-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <4FE9E981.2080402@hartkopp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.06.2012 10:49, Shawn Guo wrote:

> Here are a couple of flexcan driver/bindings updates, which are meant
> to get the driver more device tree friendly.
> 
> Shawn Guo (2):
>   net: flexcan: clock-frequency is optional for device tree probe
>   net: flexcan: add transceiver switch gpio support
> 
>  .../devicetree/bindings/net/can/fsl-flexcan.txt    |    6 ++++
>  drivers/net/can/flexcan.c                          |   30 ++++++++++++++++++++
>  2 files changed, 36 insertions(+), 0 deletions(-)
> 


Sorry Shawn, but your posting is pretty misplaced ...

Please check for the maintainers and mailing lists in the MAINTAINERS file
that match your suggested changes:

Documentation/devicetree/bindings/net/can/fsl-flexcan.txt =>

OPEN FIRMWARE AND FLATTENED DEVICE TREE
M:	Grant Likely <grant.likely@secretlab.ca>
M:	Rob Herring <rob.herring@calxeda.com>
L:	devicetree-discuss at lists.ozlabs.org (moderated for non-subscribers)
W:	http://fdt.secretlab.ca
T:	git git://git.secretlab.ca/git/linux-2.6.git
S:	Maintained
F:	Documentation/devicetree		<<<<<------------- !!!
F:	drivers/of
F:	include/linux/of*.h
K:	of_get_property
K:	of_match_table


drivers/net/can/flexcan.c =>

CAN NETWORK DRIVERS
M:	Wolfgang Grandegger <wg@grandegger.com>
M:	Marc Kleine-Budde <mkl@pengutronix.de>
L:	linux-can at vger.kernel.org
W:	http://gitorious.org/linux-can
T:	git git://gitorious.org/linux-can/linux-can-next.git
S:	Maintained
F:	drivers/net/can/			<<<<<------------- !!!
F:	include/linux/can/dev.h
F:	include/linux/can/error.h
F:	include/linux/can/netlink.h
F:	include/linux/can/platform/

So please post your suggested changes for the flexcan driver on the mailing
lists linux-can at vger.kernel.org and devicetree-discuss@lists.ozlabs.org

Once the changes are discussed and accepted they can be pulled by Dave Miller
from the CAN development git repository into the networking tree.

Thanks,
Oliver
