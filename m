From: shijie8@gmail.com (Huang Shijie)
Date: Mon, 22 Aug 2011 09:41:36 -0400
Subject: [PATCH v9 2/3] MTD : add helper functions library and header
	files for GPMI NAND driver
In-Reply-To: <201108221320.55929.marek.vasut@gmail.com>
References: <1313581828-16625-1-git-send-email-b32955@freescale.com>
	<201108201346.21647.marek.vasut@gmail.com>
	<4E51E33C.8090800@freescale.com>
	<201108221320.55929.marek.vasut@gmail.com>
Message-ID: <CAMiH66HL45x2dS2nxVtGBn8tuKUCmuD1e1uf82o8v2T9QO6h=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 22, 2011 at 7:20 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On Monday, August 22, 2011 07:03:56 AM Huang Shijie wrote:
>> Hi,
>>
>> > On Wednesday, August 17, 2011 01:50:27 PM Huang Shijie wrote:
>> >> bch-regs.h : registers file for BCH module
>> >> gpmi-regs.h: registers file for GPMI module
>> >> gpmi-lib.c: helper functions library.
>> >>
>> >> Signed-off-by: Huang Shijie<b32955@freescale.com>
>> >> ---
>
> [...]
>
>> >> +err_out:
>> >> + ?return ret;
>> >> +}
>> >> +
>> >> +/* This is very useful! */
>> >
>> > Really? Cool, what for ?
>> > btw. this should really be enclosed in some #ifdef debug or whatnot.
>>
>> Yes, it shows the register contents when DMA timeout occurs.
>> this routine is called only when error occurs.
>>
> Hi,
>
> I'd expect exactly this explanation to be in the comment ;-)
>
ok, i will do it.

thanks
Huang Shijie

> Cheers
>
