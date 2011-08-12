From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 Aug 2011 15:19:43 +0200
Subject: No mach-type for SHEEVAD?
In-Reply-To: <CAMPhdO8KgWBub5xS=JhLRum+D-=3=7s2oLNSKbWSbht3f=5A_w@mail.gmail.com>
References: <CACRpkdYi-EfCC0Lnx9bdYXyChzOhosO1C5gmggEnnBsDnzBukA@mail.gmail.com>
	<CAMPhdO8KgWBub5xS=JhLRum+D-=3=7s2oLNSKbWSbht3f=5A_w@mail.gmail.com>
Message-ID: <CACRpkdYvJR2QoQLjDuKuUOMArgotZ1mSiqmCWwL+th5NS7zJSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 4, 2011 at 11:22 AM, Eric Miao <eric.miao@linaro.org> wrote:
> On Thu, Aug 4, 2011 at 10:17 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> I tried to configure the mmp2 to build the "gplugd" variant
>> found in the arch/arm/mach-mmp2/gplugd.c source file,
>> however it fails miserably:
>>
>> arch/arm/mach-mmp/gplugd.c:183: error: 'MACH_TYPE_SHEEVAD' undeclared
>> here (not in a function)
>> make[3]: *** [arch/arm/mach-mmp/gplugd.o] Error 1
>
> Hi Russell,
>
> ISTR this entry will be there once the cleanup of mach-types is done? Or
> we can submit a new entry for this?

Is this getting anywhere? Torvald's HEAD is still broken
for gplugD. Shall I submit a new machine type so it
atleast gets fixed in the next merge window?

Thanks,
Linus Walleij
