From: nm@ti.com (Nishanth Menon)
Date: Fri, 21 Sep 2018 14:53:40 -0500
Subject: [PATCH] clk: keystone: Enable TISCI clocks if K3_ARCH
In-Reply-To: <d2027284-5265-388e-f793-cd048ac8a587@oracle.com>
References: <20180828005056.27326-1-nm@ti.com>
 <d2027284-5265-388e-f793-cd048ac8a587@oracle.com>
Message-ID: <20180921195340.jo3m5bisgntk6wsh@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 00:55-20180828, Santosh Shilimkar wrote:
> On 8/27/2018 5:50 PM, Nishanth Menon wrote:
> > K3_ARCH uses TISCI for clocks as well. Enable the same
> > for the driver support.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > 
> > Ref: https://patchwork.kernel.org/patch/10447677/
> > 
> > Since ARCH_K3 only got integrated in v4.19-rc1, rebased to v4.19-rc1 tag..
> > 
> >   drivers/clk/Makefile         | 1 +
> >   drivers/clk/keystone/Kconfig | 2 +-
> >   2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

Since it is almost a month.. Gentle poke? I am not sure when clk
gets picked up.. but checked clk-next (7be9338d38a6 Merge branch
'clk-mvebu-periph-pm' into clk-next) and linux-next ( next-20180921 )
and did'nt see the patch..

-- 
Regards,
Nishanth Menon
