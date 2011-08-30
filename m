From: olof@lixom.net (Olof Johansson)
Date: Tue, 30 Aug 2011 12:51:11 -0700
Subject: Update: ARM Sub-Architecture Maintainers workshop at Kernel
	Summit 2011
In-Reply-To: <CACxGe6vMLeHrN7jLB2=JYQON1ykOiWTeGiH8YXkUbguV0D-HEw@mail.gmail.com>
References: <CACxGe6vMLeHrN7jLB2=JYQON1ykOiWTeGiH8YXkUbguV0D-HEw@mail.gmail.com>
Message-ID: <CAOesGMjDc=H0zxRsKGycZgWE9pA_pSYSBdGhiPGjN7FNE_9paA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2011 at 11:00 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> Updated attendee list:
> Confirmed:
> 1) Nicolas Pitre - arm-soc tree maintainer
> 2) Arnd Bergmann - arm-soc tree maintainer
> 3) Olof Johansson - tegra maintainer
> 4) David Brown
> 5) Marek Vasut - Various pxa boards maintainer
> 6) Ohad Ben-Cohen
> 7) Sascha Hauer
> 8) Paul Walmsley
> 9) Catalin Marinas
> 10) Kukjin Kim - Samsung SoC maintainer
> 11) Kyungmin Park - Samsung SoC maintainer
> 12) Mark Brown - ASoC maintainer
> 13) Grant Likely
>
> Waiting for confirmation:
> 14) Pavel Machek
> 15) Eric Miao - pxa/mmp maintainer
> 16) Haojian Zhuang - pxa/mmp maintainer
> 17) Nicolas Ferre - Atmel maintainer
> 18) Will Deacon - ARM engineer
>
> Nominates, but haven't responded personally:
> 19) Russell King
> 20) Lennert Buytenhek
> 21) Marc Zyngier
> 22) Linus Walleji
>
> We're pretty close to filling up. ?Is there anyone else I should include?

I've asked Stephen Warren from Nvidia to attend if he can --
especially given the pinmux topics below.

-Olof

>
> Agenda proposals (Thanks to Nicolas and Olof):
> - DT bindings for GPIO and pin mux
> - the pin mux subsystem from linusw (especially if it is still RFC by
> ?then)
> - progress with the single zImage work
> - presentation/status of the DMA and memory management work wrt CMA
> ?(some SOC specific hacks should go away once this is available)
> - DT porting progress
> - boot architecture status
> - Report from Arnd on experiences from first arm-soc merge window
> ?- what worked well and where's room for improvement?
> ?- Any particular SoC workflow that should be tuned to make his life easier?
> ?- Where are the gaps where he needs help right now?
> ?- How did it work out for the SoC maintainers?
>
> Still accepting more proposals. ?Send me the topics you are burning to discuss.
