From: olof@lixom.net (Olof Johansson)
Date: Mon, 4 Jul 2016 22:19:24 -0700
Subject: [GIT PULL] DaVinci updates for v4.8
In-Reply-To: <576D25D6.7090907@ti.com>
References: <576D25D6.7090907@ti.com>
Message-ID: <20160705051924.GN1669@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2016 at 05:51:42PM +0530, Sekhar Nori wrote:
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.8
> 
> for you to fetch changes up to 6bce5efd442488434a317a25c5482fcd5a66bb0f:
> 
>   ARM: davinci: remove unused davinci-i2s pdata (2016-06-24 15:28:30 +0530)
> 
> ----------------------------------------------------------------
> Clean-up unused pdata for DaVinci McBSP
> audio driver and add McBSP clocks for
> DaVinci DA850 SoC.
> 
> ----------------------------------------------------------------
> Petr Kulhavy (2):
>       ARM: davinci: da850: add clocks for mcbsp0 and 1
>       ARM: davinci: remove unused davinci-i2s pdata

Merged into next/soc. Thanks.


-Olof
