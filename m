From: mpe@ellerman.id.au (Michael Ellerman)
Date: Mon, 14 Sep 2015 15:19:46 +1000
Subject: Build regressions/improvements in v4.3-rc1
In-Reply-To: <CAMuHMdVGEDKFxD7wf6ZOAGiOByM5c0Awx-anLsYGLQHV1yJW+w@mail.gmail.com>
References: <1442134868-17607-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdV31w=aDD-=uUPOqW71xLpOnH1jWeQpH=6x=vxNSo94FQ@mail.gmail.com>
 <20150913151926.GA19850@roeck-us.net>
 <CAMuHMdVGEDKFxD7wf6ZOAGiOByM5c0Awx-anLsYGLQHV1yJW+w@mail.gmail.com>
Message-ID: <1442207986.8149.0.camel@ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2015-09-13 at 22:23 +0200, Geert Uytterhoeven wrote:
> On Sun, Sep 13, 2015 at 5:19 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > arm64:allmodconfig:
> >
> > drivers/firmware/qcom_scm-32.c:196:4: error: expected string literal before ?__asmeq?
> > drivers/firmware/qcom_scm-32.c:221:2: error: implicit declaration of function ?secure_flush_area?
> > drivers/firmware/qcom_scm-32.c:239:2: error: implicit declaration of function ?outer_inv_range?
> > drivers/firmware/qcom_scm-32.c:331:4: error: expected string literal before ?__asmeq?
> > drivers/firmware/qcom_scm-32.c:361:4: error: expected string literal before ?__asmeq?
> 
> Time for kisskb to gain arm64 support?

Yes. I'll add it to my TODO list.

cheers
