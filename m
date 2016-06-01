From: horms@verge.net.au (Simon Horman)
Date: Wed, 1 Jun 2016 10:24:51 +0900
Subject: [PATCH 13/13] ARM: dts: blanche: add Ethernet support
In-Reply-To: <1669958.qjJ7i3NBPv@wasted.cogentembedded.com>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <1669958.qjJ7i3NBPv@wasted.cogentembedded.com>
Message-ID: <20160601012451.GL20527@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 01:33:49AM +0300, Sergei Shtylyov wrote:
> R8A7792  SoC  doesn't have the EtherMAC core, so SMSC  LAN89218  Ethernet
> chip was used instead on the Blanche board; this chip  is compatible with
> SMSC LAN9115  for  which there's a (device tree aware) driver. Describe
> the  chip in  the  Blanche device tree;  enable DHCP and NFS root in the
> kernel command line for the kernel booting.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

At this time I do not have access to documentation or hardware for this
board. So I am relying on you to test this and make sure it complies
with the spec.

What you have looks reasonable to me:

Acked-by: Simon Horman <horms+renesas@verge.net.au>
