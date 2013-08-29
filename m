From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Aug 2013 10:04:09 -0700
Subject: [GIT PULL v2] ARM: mvebu: DT changes for v3.12
In-Reply-To: <20130816165437.GT13964@titan.lakedaemon.net>
References: <20130814201630.GH13964@titan.lakedaemon.net>
 <20130816165437.GT13964@titan.lakedaemon.net>
Message-ID: <20130829170409.GC18542@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 16, 2013 at 12:54:37PM -0400, Jason Cooper wrote:
> Olof,
> 
> I've dropped the mv64xxx-i2c change until Gregory reworks it.
> 
> thx,
> 
> Jason.
> 
> The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:
> 
>   Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/dt-3.12

Due to the mvebu/drivers branch containing a bunch of clenaups that
conflicts, I ended up pulling this into next/soc instead of next/dt to
resolve those conflicts. This happens when you don't separate out the
cleanups in separate branches, so please do so in the future.


-Olof
