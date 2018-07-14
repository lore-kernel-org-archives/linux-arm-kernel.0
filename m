From: olof@lixom.net (Olof Johansson)
Date: Sat, 14 Jul 2018 15:11:42 -0700
Subject: [GIT PULL] pxa fixes for v4.18
In-Reply-To: <871sc9ed1h.fsf@belgarion.home>
References: <871sc9ed1h.fsf@belgarion.home>
Message-ID: <20180714221142.wupbudvvailk7tmd@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 10:24:26PM +0200, Robert Jarzmik wrote:
> Hello Arnd, Kevin, Olof,
> 
> Please consider this pull request for pxa fixes for 4.18.
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   https://github.com/rjarzmik/linux.git tags/pxa-fixes-4.18
> 
> for you to fetch changes up to 0c1049dcb4ceec640d8bd797335bcbebdcab44d2:
> 
>   ARM: pxa: irq: fix handling of ICMR registers in suspend/resume (2018-07-07 13:25:15 +0200)
> 
> ----------------------------------------------------------------
> This is the fixes set for v4.18 cycle.
> 
> This is a fix for suspending all pxa3xx platforms, where high
> number interrupts are not reenabled.

Thanks, merged.


-Olof
