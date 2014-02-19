From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 18 Feb 2014 22:19:59 -0800
Subject: [PATCH 0/2] clk: keystone: Couple of fixes for 3.14-rcx
In-Reply-To: <1392064011-11986-1-git-send-email-santosh.shilimkar@ti.com>
References: <1392064011-11986-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20140219061959.22529.87876@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Santosh Shilimkar (2014-02-10 12:26:49)
> Mike,
> 
> Can you please look at these couple of keystone clock fixes ?
> Without these, we have seen some random kernel crashes. I
> have included the dts fix since both fixes are related. Do
> let me know if you prefer dts patch to be sent it via arm-soc tree.

No problem taking these in as fixes. They go in the next batch.

Regards,
Mike

> 
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git for_3.14-rcx/clk-fixes
> 
> for you to fetch changes up to 565bbdcd3b91523b4142587c00206302e091a23e:
> 
>   ARM: keystone: dts: fix clkvcp3 control register address (2014-02-10 15:17:43 -0500)
> 
> ----------------------------------------------------------------
> Ivan Khoronzhuk (2):
>       clk: keystone: gate: fix clk_init_data initialization
>       ARM: keystone: dts: fix clkvcp3 control register address
> 
>  arch/arm/boot/dts/keystone-clocks.dtsi |    2 +-
>  drivers/clk/keystone/gate.c            |    1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> Regards,
> Santosh
> 
> -- 
> 1.7.9.5
> 
