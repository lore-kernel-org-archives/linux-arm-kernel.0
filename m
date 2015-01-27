From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 27 Jan 2015 15:24:31 +0100
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <CAL_JsqKM+2PtX_EpWXyOQHVXwf=jqVj8SroUGPO1Y2=Zj8_kMg@mail.gmail.com>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201412041857.49341@pali>
 <CAL_JsqJ9i0jwaL1cyeomQG=bhhcnEgdGWYOqkcwidyk5xOUukg@mail.gmail.com>
 <201501262016.52079@pali>
 <CAL_JsqL_EEg7tC-q8wV5v8jAfPSiri4z19iJfz2r7zntRwPyOg@mail.gmail.com>
 <20150127132127.GA869@amd>
 <CAL_JsqKM+2PtX_EpWXyOQHVXwf=jqVj8SroUGPO1Y2=Zj8_kMg@mail.gmail.com>
Message-ID: <20150127142430.GA15236@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2015-01-27 08:16:45, Rob Herring wrote:
> On Tue, Jan 27, 2015 at 7:21 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > On Mon 2015-01-26 14:33:21, Rob Herring wrote:
> >> On Mon, Jan 26, 2015 at 1:16 PM, Pali Roh?r <pali.rohar@gmail.com> wrote:

> >> This goes in the commit message.
> >>
> >> These would be non-standard fields which are not upstream. I don't
> >> know that we care in that case...
> >
> > Other devices are going to care about boot reason, too, and we might
> > as well be compatible...
> 
> What other devices? Where is bootreason in the list of ATAGS:
> 
> #define ATAG_MEM        0x54410002
> #define ATAG_VIDEOTEXT  0x54410003
> #define ATAG_RAMDISK    0x54410004
> #define ATAG_INITRD     0x54410005
> #define ATAG_INITRD2    0x54420005
> #define ATAG_SERIAL     0x54410006
> #define ATAG_REVISION   0x54410007
> #define ATAG_VIDEOLFB   0x54410008
> #define ATAG_CMDLINE    0x54410009
> #define ATAG_ACORN      0x41000101
> #define ATAG_MEMCLK     0x41000402

Anyone, whose charging involves userspace.

But the fact that it is needed on n900 should be enough.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
