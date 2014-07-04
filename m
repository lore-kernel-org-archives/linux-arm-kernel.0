From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 4 Jul 2014 10:10:33 +0530
Subject: [PATCH 2/2] mach-spear: fixed spear1340.c file
In-Reply-To: <CAPDOMViwxnTFhqio+_9A5nxygFbVJBWVXSWQd8Pj2XP6diyHQQ@mail.gmail.com>
References: <1404354994-7478-1-git-send-email-xerofoify@gmail.com>
 <1404410691.16291.11.camel@x220>
 <CAPDOMVh0qyjq11kKaO2ndYhLW8j+dZyv3-c89BBcO1AxY+fiHQ@mail.gmail.com>
 <1404412596.16291.30.camel@x220>
 <CAPDOMViwxnTFhqio+_9A5nxygFbVJBWVXSWQd8Pj2XP6diyHQQ@mail.gmail.com>
Message-ID: <CAOh2x==CVkwrr__+gjqfcdEse_+--zyPisZrQVA6nAu=vLHVOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nick,

On Fri, Jul 4, 2014 at 2:07 AM, Nick Krause <xerofoify@gmail.com> wrote:
> Very well then I will read the documentation on Kconfig in order to
> understand that and fix up my patches for that.
> On the other hand I will send a email before the patches to tell in
> what order to apply them.

As already asked by Paul, please don't top-post:
http://en.wikipedia.org/wiki/Posting_style#Top-posting

Firstly, in case we are going to get these patches in these have to be
merged together, otherwise inbetween these two we will have duplicate
functions for the same thing..

Kernel should work/build properly between commits, so that git bisect
works..

Now about this:

> -/* FIXME: Move SATA PHY code into a standalone driver */

I don't think it was just about creating another file for this. Otherwise
how hard is it for the author then?

It was probably more about updating the interface of the sata driver
to accept stub drivers, so that we don't have to keep stuff here.

So, this patch wouldn't fix the FIXME and so better drop this patchset
completely.

Thanks for trying though.

---
Viresh
