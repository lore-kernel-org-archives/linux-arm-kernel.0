From: olof@lixom.net (Olof Johansson)
Date: Mon, 27 Jul 2015 14:49:32 +0200
Subject: [GIT PULL] pxa for v4.3 - v2
In-Reply-To: <87si8de3w6.fsf@belgarion.home>
References: <87si8de3w6.fsf@belgarion.home>
Message-ID: <20150727124932.GK14224@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 09:45:13PM +0200, Robert Jarzmik wrote:
> 
> Hi Arnd, Kevin, and Olof,
> 
> This is the pxa pull request for 4.3 development cycle, the second one after a
> small fix triggered by 0-day kernel builder. It is a quite small one, the main
> work happening on the drivers side, mostly dmaengine centric work.
> 
> For the record, the diff from the previous pull request is in [1].
> 
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/rjarzmik/linux.git tags/pxa-for-4.3-v2
> 
> for you to fetch changes up to 6d6db340a7e832dc18a6a95d9f9fc79d03ff959e:
> 
>   ARM: pxa: Use setup_timer (2015-07-18 12:16:43 +0200)
> 
> ----------------------------------------------------------------
> This is the pxa changes for v4.3 cycle.
> 
> There is mostly one evolution on the dma side, to enable cooperation
> of the legacy pxa DMA API, and the new dmaengine API.
> Once all drivers using DMA are converted, the legacy DMA API should
> be removed.


Merged into next/soc. Thanks!


-Olof
