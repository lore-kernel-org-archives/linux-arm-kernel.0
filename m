From: olof@lixom.net (Olof Johansson)
Date: Sat, 26 Sep 2015 22:25:12 -0700
Subject: [GIT PULL] pxa fixes for v4.3
In-Reply-To: <87bncqo71j.fsf@belgarion.home>
References: <87bncqo71j.fsf@belgarion.home>
Message-ID: <20150927052512.GB3953@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 05:25:12PM +0200, Robert Jarzmik wrote:
> Hello Arnd, Kevin, Olof,
> 
> Please consider this pull request for pxa fixes for 4.3, made of 3 small
> regression fixes.
> 
> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
> 
>   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/rjarzmik/linux.git tags/pxa-fixes-v4.3
> 
> for you to fetch changes up to 385877c01361401113c101ef5a80a9f0998e072b:
> 
>   ARM: pxa: balloon3: Fix build error (2015-09-16 21:24:58 +0200)
> 
> ----------------------------------------------------------------
> ARM: pxa: fixes for v4.3
> 
> These fixes are mainly regression fixes triggered by irq changes,
> common clock framework introduction and sound side-effect of
> other platforms.

Thanks, merged.


-Olof
