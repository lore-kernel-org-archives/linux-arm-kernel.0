From: olof@lixom.net (Olof Johansson)
Date: Thu, 7 Jul 2016 20:41:41 -0700
Subject: [GIT PULL] pxa-dt for v4.7
In-Reply-To: <8760uyrj09.fsf@belgarion.home>
References: <8760uyrj09.fsf@belgarion.home>
Message-ID: <20160708034141.GA18763@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 30, 2016 at 09:31:18PM +0200, Robert Jarzmik wrote:
> Hi Arnd, Kevin, and Olof,
> 
> This is the pxa pull request for 4.7 device-tree. It is a tiny collection of
> fixes and pin control addition. Can you please consider pulling ?
> 
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/rjarzmik/linux.git tags/pxa-dt-4.7
> 
> for you to fetch changes up to fca43c3f7e6fe421194e9b21eabc72604edac16c:
> 
>   ARM: dts: pxa3xx: add pincontrol helpers (2016-04-20 20:20:26 +0200)
> 
> ----------------------------------------------------------------
> This device-tree pxa update brings :
>  - pin control nodes for pxa2xx and pxa3xx
>  - the LCD controller for pxa2xx
>  - the missing pxa3xx pulse width modulator nodes
>  - an USB Host fix for pxa3xx

Looks like we missed this branch when it was sent.

I've merged it for 4.8 now. Apologies about that, and please hassle us
if this happens in the future.


-Olof
