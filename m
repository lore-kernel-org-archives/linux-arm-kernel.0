From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Jul 2014 21:48:29 -0700
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC DT Updates for
 v3.17
In-Reply-To: <cover.1405398515.git.horms+renesas@verge.net.au>
References: <cover.1405398515.git.horms+renesas@verge.net.au>
Message-ID: <20140719044829.GB20064@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 06:16:36PM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these third round of Renesas ARM based SoC DT updates for v3.17.
> 
> This pull request is based on a merge of:
> 
> * The previous round of such requests, tagged as renesas-dt2-for-v3.17,
>   which you have already pulled into next/dt and;
> * The second round of Renesas ARM Based SoC Clock Updates for v3.17,
>   tagged as renesas-clock2-for-v3.17, which I have send a pull request for.
> 
> The reason for the clock update is to provide run-time dependencies
> to allow SCI to be initialised on DT on SoCs that do not yet have
> CCF support. The key word being yet, it is being worked on.
> 
> which I have already sent a pull-request for.
> 
> 
> The following changes since commit 963b0c359bf5d284fc597bed07a668cb7396bfd2:
> 
>   Merge branch 'clock-for-v3.17' into dt-for-v3.17 (2014-07-12 15:16:37 +0200)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt3-for-v3.17
> 
> for you to fetch changes up to 700ce7c2bb2a4963472d95eba1436d6b0945918e:
> 
>   ARM: shmobile: kzm9g-reference: Initialise SCIF device using DT (2014-07-12 15:16:58 +0200)

Hi,

The diffstat I got were not the same as you, I get more diffs, and more
patches. It seems that you specified your merge commit as the base, while you
had new patches applied before the merge too.

Anyway, merged since the contents looked generally OK.


-Olof
