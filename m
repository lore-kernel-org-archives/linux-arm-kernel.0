From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Mar 2016 17:49 +0100
Subject: [PATCH 0/2] ARM: uniphier: UniPhier updates for Linux 4.6-rc1
 (2nd round)
In-Reply-To: <CAK7LNARW9u=btLwc9Pj3VFx_q_unfWu9gH4sHNC3-9gLd0p=pg@mail.gmail.com>
References: <1456470968-7900-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNARJStOBUM7G=8nffXTk_a426o8CRRSX2SL-P0BsH08M7A@mail.gmail.com>
 <CAK7LNARW9u=btLwc9Pj3VFx_q_unfWu9gH4sHNC3-9gLd0p=pg@mail.gmail.com>
Message-ID: <3064565.apY2TeQbln@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 March 2016 11:01:00 Masahiro Yamada wrote:
> Olof, Arnd,
> 
> 
> I sent my patches around -rc4 and
> took action soon as requested.
> 
> But, my series is still not applied due to the long silence on your side.
> 
> Please respond!

Sorry for all the delays, we screwed this one up, and you did everything
right. I have put the DT changes into the next/dt2 branch now, and applied
the two other patches to next/soc directly.

Please check that the for-next branch in arm-soc has everything you need now.

	Arnd
