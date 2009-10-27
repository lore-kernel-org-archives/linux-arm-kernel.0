From: swetland@google.com (Brian Swetland)
Date: Tue, 27 Oct 2009 15:03:08 -0700
Subject: staging/dream: add gpio and pmem support
In-Reply-To: <20091027193330.GB19379@elf.ucw.cz>
References: <20091022091333.GA31023@elf.ucw.cz>
	<20091026234332.GB26583@kroah.com> <20091027001702.GA5019@elf.ucw.cz>
	<20091027030039.GA6195@kroah.com> <20091027081921.GG5019@elf.ucw.cz>
	<20091027165750.GA24477@kroah.com> <20091027193330.GB19379@elf.ucw.cz>
Message-ID: <a55d774e0910271503u40184a37ub493cfb3ed37adba@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2009 at 12:33 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
> (Plus, of course I'd like some help, but google people seem very
> silent :-( ).

Hi Pavel,

The Android kernel team is completely buried in issues related to fall
09 devices -- we're just not going to have cycles for sorting out
stuff related to going upstream until we're past that (probably
mid-late November).  Yeah, this totally sucks, but that's where we
are.  We're definitely going to be rebasing all our working trees up
to 2.6.32/33 for the end of the year and doing a push to get more
stuff cleaned up and push towards mainline.

My hope remains that once we get more of the core msm support and
device support out there we can get patches send upstream more
incrementally in the future instead of these big blobs of code.  We
need to adjust our working model to be more involved with the mainline
day-by-day while still supporting "stable" branches that can make it
into production hardware.  Fun times.

Brian
