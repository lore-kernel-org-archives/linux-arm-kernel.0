From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Nov 2014 18:52:53 -0400
Subject: [PATCHv0 0/2] arm: mvebu: non-critical fixes for NETGEAR
 ReadyNAS 102
In-Reply-To: <cover.1414185031.git.arno@natisbad.org>
References: <cover.1414185031.git.arno@natisbad.org>
Message-ID: <20141101225253.GE3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 11:21:52PM +0200, Arnaud Ebalard wrote:
> Hi,
> 
> This two patches are non-critical and respectively fix the following
> in RN102 .dts file:
>  - the color for LEDs labels (they are blue, and not green)
>  - eSATA/SATA ports info
> 
> Arnaud Ebalard (2):
>   arm: mvebu: fix LED color in NETGEAR ReadyNAS 102 .dts file
>   arm: mvebu: clarify (e)SATA ports info in NETGEAR ReadyNAS 102 .dts file
> 
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)

Both applied to mvebu/dt with Gregory and Andrew's Acks.  Also fixed the
commit typo in the second patch.

thx,

Jason.
