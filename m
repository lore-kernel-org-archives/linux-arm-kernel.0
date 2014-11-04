From: olof@lixom.net (Olof Johansson)
Date: Mon, 3 Nov 2014 22:32:35 -0800
Subject: [GIT PULL] Integrator multiplatform migration for v3.19
In-Reply-To: <CACRpkdafst1j2tp4-=BZMn_P688uUSjeAZEGt26WuD_d521sHQ@mail.gmail.com>
References: <CACRpkdafst1j2tp4-=BZMn_P688uUSjeAZEGt26WuD_d521sHQ@mail.gmail.com>
Message-ID: <20141104063235.GG13562@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 02:13:04PM +0200, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> this is the initial set of two patches to migrate the Integrator
> platforms to multiplatform.
> 
> Tested on the Integrator/AP with ARM926EJ-S and Integrator/CP
> with ARM920T.
> 
> Please pull it in for v3.19!
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> tags/integrator-multiplatform-for-arm-soc
> 
> for you to fetch changes up to 9713497b6c64c67c8763f8f07fad325b193764b6:
> 
>   ARM: integrator: set V4T and V5 as default multitargets (2014-10-22
> 09:49:26 +0200)
> 
> ----------------------------------------------------------------
> Multiplatform migration of the Integrator.

Merged. The patches had better commit texts than the tag though, so please
feel free to carry forward and/or elaborate just a bit more in the future.


-Olof
