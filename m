From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 4 Apr 2012 09:53:23 -0600 (MDT)
Subject: [PATCH] ARM: OMAP2+: hwmod: Fix wrong SYSC_TYPE1_XXX_MASK bit
 definitions
In-Reply-To: <1329477961-1307-1-git-send-email-hvaibhav@ti.com>
References: <1329477961-1307-1-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.00.1204040953120.8000@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Feb 2012, Vaibhav Hiremath wrote:

> In the SYSC_TYPE1_XXX_MASK configuration, SYSC_XXX_SHIFT macro
> is used which is not defined anywhere in the kernel.
> Until now the build was going through successfully, since it
> is not being used anywhere in kernel.
> 
> This bug got introduced by the commit
> 358f0e630d5409ab3837b86db3595560eae773b6 ("OMAP3: hwmod: support
> to specify the offset position of various SYSCONFIG register bits.")
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks, queued for 3.4-rc.

- Paul
