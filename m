From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Sep 2012 22:56:47 -0700
Subject: [GIT PULL 2/4] mxs sparse-irq support
In-Reply-To: <1347350100-4674-3-git-send-email-shawn.guo@linaro.org>
References: <1347350100-4674-1-git-send-email-shawn.guo@linaro.org>
 <1347350100-4674-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120913055647.GF24290@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 03:54:57PM +0800, Shawn Guo wrote:
> The following changes since commit d9875690d9b89a866022ff49e3fcea892345ad92:
> 
>   Linux 3.6-rc2 (2012-08-16 14:51:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-sparse-irq
> 
> for you to fetch changes up to 6608f13fabdb1f9ecbd502763ba33ca2646834c8:
> 
>   ARM: mxs: remove mach/irqs.h (2012-09-03 09:32:17 +0800)
> 
> ----------------------------------------------------------------
> mxs-sparse-irq
> 
> The series adds irqdomain support for mach-mxs and then enables
> sparse-irq.  It dependes on pull request mxs-dt-3.7.

Thanks, pulled in under next/soc2 due to the dt dependency.

However, for the future: if you're truly dependent on the dt branch to
build/boot, you should use that as a base for this branch. Otherwise you
can end up in a state with git bisect where you only have this branch
applied but not the other one.


-Olof
