From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 13 Jul 2014 17:46:25 -0400
Subject: [PATCH 0/2] Add DT support for LaCie NAS d2 Network v2
In-Reply-To: <1404830545-15581-1-git-send-email-simon.guinot@sequanux.org>
References: <1401132591-26305-1-git-send-email-andrew@lunn.ch>
 <1404830545-15581-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20140713214625.GE13108@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 04:42:23PM +0200, Simon Guinot wrote:
> Hi,
> 
> This patch series completes the DT conversion for the LaCie Kirkwood
> based boards by adding DT support for the d2 Network v2.
> 
> Regards,
> 
> Simon
> 
> Simon Guinot (2):
>   ARM: Kirkwood: allow to use netxbig DTSI for d2net_v2 DTS
>   ARM: Kirkwood: add DT support for d2 Network v2
> 
>  arch/arm/boot/dts/Makefile              |  1 +
>  arch/arm/boot/dts/kirkwood-d2net.dts    | 42 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-net2big.dts  | 30 +++++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-net5big.dts  | 28 ++++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-netxbig.dtsi | 26 --------------------
>  5 files changed, 101 insertions(+), 26 deletions(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-d2net.dts

Both applied to mvebu/dt with Andrew's Ack.

thx,

Jason.
