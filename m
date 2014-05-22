From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 May 2014 22:08:40 -0700
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC r7s72100-ccf
 Updates for v3.16
In-Reply-To: <cover.1400289483.git.horms+renesas@verge.net.au>
References: <cover.1400289483.git.horms+renesas@verge.net.au>
Message-ID: <20140522050840.GA32618@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 17, 2014 at 10:24:53AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Second Round of
> Renesas ARM Based SoC r7s72100 CCF Updates for v3.16.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-r7s72100-ccf-for-v3.16,
> which I have already sent a pull-request for.
> 
> This comprehensively addresses an oversight in patches included in
> the pull request that it depends on, specifically leaving broken
> non-multiplatform support in place for genmai-reference.
> 
> This pull request has some minor conflicts with other DT changes which I
> have previously sent pull requests for. These conflicts are in
> arch/arm/boot/dts/Makefile. A resolution can be found in the
> renesas-next-v3.15-rc1-20140517 tag if my renesas tree. In words:
> 
>     CONFIG_ARCH_SHMOBILE_LEGACY hunk:
>     * Remove emev2-kzm9d.dtb
>     * Remove r7s72100-genmai-reference.dtb
>     * Keep r7s72100-genmai.dtb
> 

Are you sure? Shouldn't the genmai board be covered by multi now? Or
are both multi and legacy driven by the same DTS now? Just making sure.

> The following changes since commit 9fbb1ae01b878e2cce9626fa6fdc9e5dcefeb6b5:
> 
>   ARM: shmobile: r7s72100: use workaround for non DT-clocks (2014-05-14 11:42:55 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-r7s72100-ccf2-for-v3.16
> 
> for you to fetch changes up to a5176e0d9de31a54e08468f21c15dc08e006857f:
> 
>   ARM: shmobile: Remove Genmai reference DTS (2014-05-17 09:06:29 +0900)
> 

Pulled, thanks.


-Olof
