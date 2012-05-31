From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 31 May 2012 09:50:15 +0200
Subject: [GIT PULL] at91: platform data for atmel-mci (for 3.5)
In-Reply-To: <4FBE4FE7.3010005@atmel.com>
References: <4FBE4FE7.3010005@atmel.com>
Message-ID: <4FC722B7.10409@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2012 05:12 PM, Nicolas Ferre :
> Hi Arnd, hi Olof,

Ping?

(or maybe you will have a look at this after the merge window...)

> Here is an additional AT91 patch for 3.5 concerning platform data
> related to atmel-mci driver. It is maybe a bit late on your side
> but you can choose to sent it during 3.5-rc cycle considering the
> reasons that I give in the tag comment...
> 
> If you feel it does not have to integrate 3.5, having it in
> a kind of "staging" or "late" branch can help us to exercise it
> in linux-next.
> 
> (is merges seamlessly with current Linus' tree as the commit that I have
> based my tag upon is already integrated upstream)
> 
> The following changes since commit cce783c608fee0716cff65926d1835a5fd097b69:
> 
>   ARM: at91: Add DT description files for AT91SAM9N12-EK (2012-04-28 01:40:27 +0800)
> 
> are available in the git repository at:
> 
>   git://github.com/at91linux/linux-at91.git tags/at91-for-next-soc
> 
> for you to fetch changes up to 6df5c23817852e865c452e72414063acd0cd7309:
> 
>   ARM: at91: add atmel-mci support for chips and boards which can use it (2012-05-21 12:30:41 +0200)
> 
> ----------------------------------------------------------------
> This addition of platform data for atmel-mci driver in AT91 SoC & boards
> will temporary overload the information for at91_mci driver.
> This situation will end in 3.7 when the at91_mci driver marked deprecated
> will be removed. At this time, all platform data for this old driver will
> be erased from all SoC & boards files.
> The sooner we provide elements for people to switch to this newer and more
> stable driver, the better we will run this transition.
> 
> ----------------------------------------------------------------
> Ludovic Desroches (1):
>       ARM: at91: add atmel-mci support for chips and boards which can use it
> 
>  arch/arm/mach-at91/at91rm9200_devices.c  |   99 ++++++++++++++++++
>  arch/arm/mach-at91/at91sam9261_devices.c |   67 ++++++++++++
>  arch/arm/mach-at91/at91sam9263.c         |    2 +
>  arch/arm/mach-at91/at91sam9263_devices.c |  164 ++++++++++++++++++++++++++++++
>  arch/arm/mach-at91/at91sam9rl_devices.c  |   70 +++++++++++++
>  arch/arm/mach-at91/board-afeb-9260v1.c   |   14 +++
>  arch/arm/mach-at91/board-carmeva.c       |   14 +++
>  arch/arm/mach-at91/board-cpu9krea.c      |   14 +++
>  arch/arm/mach-at91/board-cpuat91.c       |   14 +++
>  arch/arm/mach-at91/board-csb337.c        |   14 +++
>  arch/arm/mach-at91/board-eb9200.c        |   14 +++
>  arch/arm/mach-at91/board-ecbat91.c       |   14 +++
>  arch/arm/mach-at91/board-eco920.c        |   14 +++
>  arch/arm/mach-at91/board-flexibity.c     |   14 +++
>  arch/arm/mach-at91/board-foxg20.c        |   16 ++-
>  arch/arm/mach-at91/board-kb9202.c        |   14 +++
>  arch/arm/mach-at91/board-neocore926.c    |   14 +++
>  arch/arm/mach-at91/board-picotux200.c    |   14 +++
>  arch/arm/mach-at91/board-qil-a9260.c     |   14 +++
>  arch/arm/mach-at91/board-rm9200dk.c      |   14 +++
>  arch/arm/mach-at91/board-rm9200ek.c      |   14 +++
>  arch/arm/mach-at91/board-rsi-ews.c       |   14 +++
>  arch/arm/mach-at91/board-sam9-l9260.c    |   16 ++-
>  arch/arm/mach-at91/board-sam9260ek.c     |   16 ++-
>  arch/arm/mach-at91/board-sam9261ek.c     |   14 +++
>  arch/arm/mach-at91/board-sam9263ek.c     |   14 +++
>  arch/arm/mach-at91/board-sam9rlek.c      |   14 +++
>  arch/arm/mach-at91/board-usb-a926x.c     |    2 +-
>  arch/arm/mach-at91/board-yl-9200.c       |   14 +++
>  29 files changed, 728 insertions(+), 4 deletions(-)
> 
> Thanks, best regards,


-- 
Nicolas Ferre
