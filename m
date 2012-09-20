From: jrbenito@benito.qsl.br (Josenivaldo Benito Junior)
Date: Thu, 20 Sep 2012 18:48:21 -0300
Subject: Adding new board to Kernel
In-Reply-To: <505AC5D6.8040702@antcom.de>
References: <CAOYb-CL9WM8wzko7CsQvYAAWKARnTkrqenBtsgchn96t=x4wyg@mail.gmail.com>
 <201209191855.39859.arnd@arndb.de> <505AC5D6.8040702@antcom.de>
Message-ID: <CAOYb-CKNVLEfvXRW6mMsasDkWmCxVH4cO2b-3bXEm=QDbWrEew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I will check that!

thanks

--*
Josenivaldo Benito Jr.*
*PU2LBD*

*Por Aur?lio Buarque de Hollanda,  elite, do franc?s ?lite, significa ?o
que h? de melhor em uma sociedade, minoria prestigiada, constitu?da pelos
indiv?duos mais aptos?.



On Thu, Sep 20, 2012 at 4:29 AM, Roland Stigge <stigge@antcom.de> wrote:

> Hi,
>
> On 09/19/2012 08:55 PM, Arnd Bergmann wrote:
> >> The Embedded Artists has a board based on ARM LPC3250 called EA3250 and
> >> they provide a BSP with patch to Linux Kernel version 2.6.29.2. I am
> trying
> >> to "up merge" this patch to Kernel v3.4 (now 3.5) and after that get it
> in
> >> the mainstream. Although I have a working version (
> >> https://github.com/jrbenito/Kernel-LPC3250) I still have doubts on how
> to
> >> correct submit it to mainline kernel.
> >>
> >> -The machine type is already registered in past (
> >> http://www.arm.linux.org.uk/developer/machines/list.php?id=2512) but
> it is
> >> not in mainline. Since I shall not patch this file, how can I ask to it
> be
> >> updated with ea3250 board information?
>
> We already have ea3250.dts in mainline since v3.5.
>
> Roland
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120920/c979272a/attachment-0001.html>
