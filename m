From: digetx@gmail.com (Dmitry Osipenko)
Date: Sat, 27 Jul 2013 22:29:23 +0400
Subject: [PATCH 0/8] ARM: tegra: support LP1 suspend mode
In-Reply-To: <51F410BE.3000904@gmail.com>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <2389689.JgQlW00RdN@ax5200p> <51F3F356.8080709@gmail.com>
 <4555938.6N2HxzJnNO@ax5200p> <51F410BE.3000904@gmail.com>
Message-ID: <51F41183.5070305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

27.07.2013 22:26, Dmitry Osipenko ?????:
> It might be a known problem only for those who faced with it. Since it's on
> their internal irc, it wasn't a known issue.
> 
> It also would be interesting to know if suspend with thumb2 works correctly. On
> 3.8 I've ported lp0 suspend and it works fine with arm compiled kernel, thumb2
> also works but only for about 5-10 hours (resuming on each 5-30 minutes, default
> android behavior) and after I'm getting pmd corruption. I have no idea from
> where that corruption comes from without ability for hw debugging.
s/irc/bug tracker/ :)
