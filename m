From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 28 Jul 2012 21:02:51 +0800
Subject: [PATCH v2 3/3] ARM: imx_v6_v7_defconfig: Select MXS_DMA
In-Reply-To: <CAOMZO5CKK68sgT+Q31OuMbFQ5uL4j3zbs2zZQfPyHtt0ZLkX3A@mail.gmail.com>
References: <1343215100-24005-1-git-send-email-festevam@gmail.com>
 <1343215100-24005-3-git-send-email-festevam@gmail.com>
 <CAMiH66EA4O0s8hfXkr_SJ56+q7eZ8w0=3C1r_C+m2Os1RxprmA@mail.gmail.com>
 <CAOMZO5BfT+_7x4F96Kvqtq5STXxw2Y9CxbCCAc_UnZ-3wy0qxg@mail.gmail.com>
 <CAMiH66FUxiw0B8iD5rYi=nUX0VYZBzOKifXKfTqd1RmSHhC80g@mail.gmail.com>
 <20120726022930.GB3396@shlinux2.ap.freescale.net>
 <CAOMZO5CKK68sgT+Q31OuMbFQ5uL4j3zbs2zZQfPyHtt0ZLkX3A@mail.gmail.com>
Message-ID: <20120728130249.GF2128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 07:38:57AM -0300, Fabio Estevam wrote:
> On Wed, Jul 25, 2012 at 11:29 PM, Dong Aisheng <b29396@freescale.com> wrote:
> 
> > How about using 'select MXS_DMA'?
> 
> Ok, I prefer this way too. Will resubmit it soon. Hopefully it is OK with Shawn.

No.  For your information, the following is what
Documentation/kbuild/kconfig-language.txt tell.

  Note:
        select should be used with care. select will force
        a symbol to a value without visiting the dependencies.
        By abusing select you are able to select a symbol FOO even
        if FOO depends on BAR that is not set.
        In general use select only for non-visible symbols
        (no prompts anywhere) and for symbols with no dependencies.
        That will limit the usefulness but on the other hand avoid
        the illegal configurations all over.

-- 
Regards,
Shawn
