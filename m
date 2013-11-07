From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 7 Nov 2013 15:01:39 +0800
Subject: [PATCH v3 9/9] ARM: add initial support for Marvell Berlin SoCs
In-Reply-To: <20131107134033.59bd127a@xhacker>
References: <1381235073-17134-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1383661723-17956-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1383661723-17956-10-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131107134033.59bd127a@xhacker>
Message-ID: <20131107150139.26b321f4@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Nov 2013 21:40:33 -0800
Jisheng Zhang <jszhang@marvell.com> wrote:

...
> > +	select ARM_GIC  
> ARM_GIC is common on berlin SoCs. we can put it below ARCH_BERLIN?
> > +	select CACHE_L2X0  
> ditto

Sorry. After some consideration, CACHE_L2X0 is not common (BG3). So please ignore
this line

Thanks
