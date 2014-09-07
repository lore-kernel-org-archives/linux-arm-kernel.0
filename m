From: charlebm@gmail.com (Mark Charlebois)
Date: Sat, 6 Sep 2014 19:30:06 -0700
Subject: [PATCH] arm64: LLVMLinux: Provide __aeabi_* symbols which are
 needed for clang
In-Reply-To: <2954780.2t9bpyu7ov@wuerfel>
References: <1409959394-14936-1-git-send-email-behanw@converseincode.com>
 <2954780.2t9bpyu7ov@wuerfel>
Message-ID: <CAFzeTN0AO40k2ObpMX3xPOmKaiGdiLREev1A2J0sE=B7z64qug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 6, 2014 at 7:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Friday 05 September 2014 16:23:14 behanw at converseincode.com wrote:
> > --- /dev/null
> > +++ b/arch/arm64/lib/eabi.c
> > @@ -0,0 +1,32 @@
> > +/*
> > + *  linux/lib/eabi.c
>
> Please don't put the file names in the files themselves, it's redundant
> and in this case actually wrong.

Sorry, will fix.

>
> > + *  Copyright (C) 2012  Mark Charlebois
> > + */
> > +
> > +/*
> > + * EABI routines
>
> Does EABI specify these function names? I would think that they are
> just random libgcc (whatever that is called in clang) functions.

http://infocenter.arm.com/help/topic/com.arm.doc.ihi0043d/IHI0043D_rtabi.pdf

See section 4.3.4 Memory copying, clearing, and setting

>
>         Arnd
