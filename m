From: eric.miao@linaro.org (Eric Miao)
Date: Thu, 4 Aug 2011 10:22:49 +0100
Subject: No mach-type for SHEEVAD?
In-Reply-To: <CACRpkdYi-EfCC0Lnx9bdYXyChzOhosO1C5gmggEnnBsDnzBukA@mail.gmail.com>
References: <CACRpkdYi-EfCC0Lnx9bdYXyChzOhosO1C5gmggEnnBsDnzBukA@mail.gmail.com>
Message-ID: <CAMPhdO8KgWBub5xS=JhLRum+D-=3=7s2oLNSKbWSbht3f=5A_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

ISTR this entry will be there once the cleanup of mach-types is done? Or
we can submit a new entry for this?

- eric

On Thu, Aug 4, 2011 at 10:17 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> I tried to configure the mmp2 to build the "gplugd" variant
> found in the arch/arm/mach-mmp2/gplugd.c source file,
> however it fails miserably:
>
> arch/arm/mach-mmp/gplugd.c:183: error: 'MACH_TYPE_SHEEVAD' undeclared
> here (not in a function)
> make[3]: *** [arch/arm/mach-mmp/gplugd.o] Error 1
>
> Which is not strange given that it's not in mach-types.
> Nor does it appear to ever have been there, and I wonder
> if it was ever submitted to Russells machine registry.
>
> Can the subarch maintainers tell us how to deal with this,
> say like delete the boardfile or add the machine type?
>
> Thanks,
> Linus Walleij
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
