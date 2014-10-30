From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 30 Oct 2014 13:41:01 +0100
Subject: [PATCHv0 0/2] arm: mvebu: non-critical fixes for NETGEAR ReadyNAS
 102
In-Reply-To: <cover.1414185031.git.arno@natisbad.org>
References: <cover.1414185031.git.arno@natisbad.org>
Message-ID: <545231DD.7090500@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On 24/10/2014 23:21, Arnaud Ebalard wrote:
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
> 

For both patches:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
