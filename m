From: horms@verge.net.au (Simon Horman)
Date: Mon, 26 Mar 2018 11:03:20 +0200
Subject: [PATCH v2] arm64: dts: renesas: eagle: add EtherAVB pins
In-Reply-To: <382aeecb-c484-ec27-1ef1-8da1673c2c14@cogentembedded.com>
References: <382aeecb-c484-ec27-1ef1-8da1673c2c14@cogentembedded.com>
Message-ID: <20180326090319.567udho6m3gsfy6r@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2018 at 10:58:33PM +0300, Sergei Shtylyov wrote:
> Add the (previously omitted) EtherAVB pin data to the Eagle board's
> device tree.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'renesas-devel-20180314-v4.16-rc5' tag of Simon's
> 'renesas.git repo. It depends on the R8A77970 PFC driver patch adding EtherAVB
> pin groups (posted yesterday) in order to work properly...

Thanks, I have marked this as deferred, please either:
* repost or ping me once the dependency is in an RC release or;
* let me know that its safe to apply this change - that is, it won't cause
  a regression - without the dependency
