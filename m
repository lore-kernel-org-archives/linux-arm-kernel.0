From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 26 Jun 2013 10:55:04 +0100
Subject: [GIT PULL] ARM DT cpus/cpu bindings documentation updates
In-Reply-To: <20130523103315.GA2866@e102568-lin.cambridge.arm.com>
References: <20130523103315.GA2866@e102568-lin.cambridge.arm.com>
Message-ID: <20130626095504.GC22333@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant, Rob,

On Thu, May 23, 2013 at 11:33:15AM +0100, Lorenzo Pieralisi wrote:
> Hi Grant, Rob,
> 
> please pull the cpus/cpu nodes bindings updates for ARM. This pull
> request completes my previous pull request:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/169110.html

Please let me know if you have any objection to these two pull requests
(the one I am replying to and the one provided in the link above). I
sent them quite early so I am just reminding you lest you missed them.

These bindings are quite important and without them all in-kernel dts files,
cpu map parsing code and topology updates are meaningless, I really hope you
can queue them for this upcoming merge window.

They are based against early kernel versions (3.10-rc1 and 3.10-rc2), but
they fast-forward cleanly to -rc7, please let me know if you want me to
send pull requests with branches updated to -rc7, I do not think it is
necessary.

Thank you very much indeed,
Lorenzo

> 
> with the required changes for cpus/cpu nodes.
> 
> Thanks a lot,
> Lorenzo
> 
> The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:
> 
>   Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)
> 
> are available in the git repository at:
> 
>   git://linux-arm.org/linux-2.6-lp.git dt-cpus-bindings
> 
> for you to fetch changes up to 8e11f862d6a5491bb5f8ef73e13cfd66562e7be3:
> 
>   Documentation: devicetree: arm: cpus/cpu nodes bindings updates (2013-05-23 10:46:46 +0100)
> 
> ----------------------------------------------------------------
> Lorenzo Pieralisi (1):
>       Documentation: devicetree: arm: cpus/cpu nodes bindings updates
> 
>  Documentation/devicetree/bindings/arm/cpus.txt | 459 ++++++++++++++++++++++---
>  1 file changed, 412 insertions(+), 47 deletions(-)
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
