From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Jan 2015 17:43:01 -0800
Subject: [GIT PULL] DaVinci cleanups for v3.20
In-Reply-To: <1421766325-28293-2-git-send-email-nsekhar@ti.com>
References: <1421766325-28293-1-git-send-email-nsekhar@ti.com>
 <1421766325-28293-2-git-send-email-nsekhar@ti.com>
Message-ID: <20150122014301.GG31815@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 08:35:25PM +0530, Sekhar Nori wrote:
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.20/cleanup
> 
> for you to fetch changes up to 65010564d698ef99b24b04a16e7bcabcd6171c64:
> 
>   ARM: davinci: Remove CDCE949 driver (2015-01-20 19:29:58 +0530)
> 
> ----------------------------------------------------------------
> Removes an unused function and the unused
> support for CDCE949 clock generator.
> 
> ----------------------------------------------------------------
> Rickard Strandqvist (2):
>       ARM: davinci: serial.c: remove unused serial_read_reg()
>       ARM: davinci: Remove CDCE949 driver

Thanks, merged into next/cleanups.


-Olof
