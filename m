From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Sep 2012 07:33:03 +0000
Subject: Adding new board to Kernel
In-Reply-To: <505AC5D6.8040702@antcom.de>
References: <CAOYb-CL9WM8wzko7CsQvYAAWKARnTkrqenBtsgchn96t=x4wyg@mail.gmail.com>
 <201209191855.39859.arnd@arndb.de> <505AC5D6.8040702@antcom.de>
Message-ID: <201209200733.03693.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 September 2012, Roland Stigge wrote:
> On 09/19/2012 08:55 PM, Arnd Bergmann wrote:
> >> The Embedded Artists has a board based on ARM LPC3250 called EA3250 and
> >> they provide a BSP with patch to Linux Kernel version 2.6.29.2. I am trying
> >> to "up merge" this patch to Kernel v3.4 (now 3.5) and after that get it in
> >> the mainstream. Although I have a working version (
> >> https://github.com/jrbenito/Kernel-LPC3250) I still have doubts on how to
> >> correct submit it to mainline kernel.
> >>
> >> -The machine type is already registered in past (
> >> http://www.arm.linux.org.uk/developer/machines/list.php?id=2512) but it is
> >> not in mainline. Since I shall not patch this file, how can I ask to it be
> >> updated with ea3250 board information?
> 
> We already have ea3250.dts in mainline since v3.5.
> 

Ah, I see.

	Arnd
