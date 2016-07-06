From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Jul 2016 20:58:28 -0700
Subject: [GIT PULL 1/5] i.MX cleanup for 4.8
In-Reply-To: <1467117980-20063-1-git-send-email-shawnguo@kernel.org>
References: <1467117980-20063-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20160706035828.GB23212@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 08:46:16PM +0800, Shawn Guo wrote:
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-cleanup-4.8
> 
> for you to fetch changes up to 44af782227b3977b98be6967533b0d23add40eb4:
> 
>   ARM: imx: remove cpu_is_mx*() (2016-06-28 10:26:45 +0800)
> 
> ----------------------------------------------------------------
> The i.MX cleanup for 4.8:
>  - A series from Arnd to clean up cpu_is_mx*() from i.MX platform
>  - A series from Andrey to clean up i.MX L2-cache code by using
>    core support as much as possible
>  - Remove the orphan header eukrea-baseboards.h from i.MX platform
>  - Remove boilerplate code from TZIC driver by using IRQCHIP_DECLARE

Applied, thanks.


-Olof
