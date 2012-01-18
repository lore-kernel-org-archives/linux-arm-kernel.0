From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 18 Jan 2012 18:07:12 +0800
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <CAMsRxfLtLnMiP0ZGr6rNLv-UeLUwOSJ=7do2nezOU5OkOA+MbQ@mail.gmail.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
 <4F0B182D.7060507@us.ibm.com>
 <20120109224945.GA23090@mudshark.cambridge.arm.com>
 <CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
 <CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
 <CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
 <CAMsRxfLtLnMiP0ZGr6rNLv-UeLUwOSJ=7do2nezOU5OkOA+MbQ@mail.gmail.com>
Message-ID: <CACVXFVMbrQGi4Sg9TUPP5Bcc5kzFoX74n=ii4QrDRudbuDHOGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 18, 2012 at 5:54 PM, stephane eranian <eranian@googlemail.com>
> Should I use Will's -next tree as the base instead of Linus'?

Either one is OK. If you use linus tree as base, you need to apply the #1 and
#2 patch manually.

> Given that MARC is shutdown today, would you mind packing those patches
> into a tarball and sending them to me directly?

See attachment, which includes the patches from #3 to #6.

>
> When you mention Will's -next tree, are you talking about:
> git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf

It is perf/omap4 brach, you can pick up the two patches[1][2] directly from
the branch.


thanks,
--
Ming Lei

[1], http://git.kernel.org/?p=linux/kernel/git/will/linux.git;a=commit;h=7924a3eba0766348d6d6a56cbb9873cdbcab0d8c

[2], http://git.kernel.org/?p=linux/kernel/git/will/linux.git;a=commit;h=bde071f005e2dc71378aff69e86b961d8cd7922f
-------------- next part --------------
A non-text attachment was scrubbed...
Name: omap4_pmu.tar.gz
Type: application/x-gzip
Size: 7423 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120118/650d6340/attachment-0001.gz>
