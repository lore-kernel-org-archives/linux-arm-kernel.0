From: olof@lixom.net (Olof Johansson)
Date: Sat, 2 Jun 2018 01:20:18 -0700
Subject: [GIT PULL] pxa for v4.18
In-Reply-To: <87d0xftunu.fsf@belgarion.home>
References: <87d0xftunu.fsf@belgarion.home>
Message-ID: <20180602082018.t4tnffy2plqqntcr@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2018 at 10:03:17PM +0200, Robert Jarzmik wrote:
> Hi Arnd, Kevin, and Olof,
> 
> This is the pxa pull request for 4.18, a minor one.
> 
> Can you please consider pulling ?
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/rjarzmik/linux.git tags/pxa-for-4.18
> 
> for you to fetch changes up to c1c14f8954c6d1cb9867024618e93687d9d035ba:
> 
>   ARM: pxa3xx: enable external wakeup pins (2018-05-25 22:40:17 +0200)
> 
> ----------------------------------------------------------------
> This is is the pxa changes for v4.18 cycle :
>  - change to phase out at24 eeprom platform data
>  - add a missing wakeup pin on pxa320 SoCs

Hi,

This is coming in very late, but it's also a pretty small pull request so I've
merged it for v4.18. If you can, please try to get your staged patches set
around rc5/rc6 timeframe.


Thanks,


-Olof
