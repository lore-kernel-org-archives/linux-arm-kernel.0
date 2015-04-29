From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 29 Apr 2015 16:11:47 +0100
Subject: [PATCH v6 4/4] clk: dt: Introduce binding for always-on clock
 support
In-Reply-To: <CAMuHMdVdtoXGhK97Ky5hoVcjM6XZAZXKWELL64MFQebMpFr2Ng@mail.gmail.com>
References: <1428432239-4114-5-git-send-email-lee.jones@linaro.org>
 <20150407191746.GA26727@lukather> <20150408081450.GB5162@x1>
 <20150408094349.GC26727@lukather> <20150408103832.GG5162@x1>
 <20150408155705.GF26727@lukather> <20150408172344.GH5162@x1>
 <20150422093446.GA28007@lukather> <20150429141751.GR9169@x1>
 <CAMuHMdVdtoXGhK97Ky5hoVcjM6XZAZXKWELL64MFQebMpFr2Ng@mail.gmail.com>
Message-ID: <20150429151147.GX9169@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Apr 2015, Geert Uytterhoeven wrote:
> On Wed, Apr 29, 2015 at 4:17 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > This useful binding should be accepted and people should not abuse
> > it.  If they do and the vendor Maintainer's review and accept then
> > they have no foundation for recourse.
> >
> > Would you prefer it if I made the warning starker?
> 
> Perhaps you can add a check for "clock-always-on" to scripts/checkpatch.pl,
> to make people aware they should think twice?

That's a really nice idea!

Maxime, would that make you happ(y|ier)?

> Nah, people don't read documentation, don't run checkpatch, ignore compiler
> warnings, etc...

:)

You can only wrap people in so much cotton wool.  If they then decide
to ignore all the warnings and jump, woe betide them.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
