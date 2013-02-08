From: sangsu4u.park@samsung.com (Sangsu Park)
Date: Fri, 08 Feb 2013 17:57:08 +0900
Subject: [RESEND][PATCH] ARM: EXYNOS: Add clocks for EXYNOS I2S and PCM I/F
In-Reply-To: <CAAgF-Be1UKyyX0VBkdy7GbhxH4mZmsVwskr2Yj3TM54qjs6dEQ@mail.gmail.com>
References: <003201ce0429$c15e8350$441b89f0$@samsung.com>
 <CAAgF-Be1UKyyX0VBkdy7GbhxH4mZmsVwskr2Yj3TM54qjs6dEQ@mail.gmail.com>
Message-ID: <011101ce05da$46be7760$d43b6620$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 8, 2013 at 13:23 PM, Padma Venkat <padma.kvr@gmail.com> wrote:
> On Wed, Feb 6, 2013 at 10:51 AM, Sangsu Park <sangsu4u.park@samsung.com>
wrote:
> > +void __init exynos_register_audss_clocks(void)
> > +{
> > +       clk_audss_base = ioremap(EXYNOS_PA_AUDSS, SZ_4K);
> > +       if (clk_audss_base == NULL) {
> 
> Please run checkpatch. There should be space after if.

I mistakenly forgot checking patch with checkpatch.
I can find some errors and warnings about this patch.
I'll fix them. Thank you for your comment.

> 
> > +               pr_err("unable to ioremap for gpio_base1\n");
> 
> Please fix the err message.

I'll change it. :)

Thanks.
Sangsu Park
