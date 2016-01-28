From: tony@atomide.com (Tony Lindgren)
Date: Thu, 28 Jan 2016 11:07:48 -0800
Subject: [PATCH 0/2] ARM: shmobile: Move written variables from .text to
 .data
In-Reply-To: <20160128174848.GO10826@n2100.arm.linux.org.uk>
References: <1453993462-12210-1-git-send-email-geert+renesas@glider.be>
 <CAGXu5jL7ebTXtPu5_9U4duju2qiWFEYVQmSSgpdMDkWr8tQCvw@mail.gmail.com>
 <20160128174848.GO10826@n2100.arm.linux.org.uk>
Message-ID: <20160128190748.GJ19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [160128 09:50]:
> On Thu, Jan 28, 2016 at 07:19:34AM -0800, Kees Cook wrote:
> > 
> > And FWIW, I've now got the RODATA patch back in the patch queue, since
> > we're at -rc1:
> > http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8501/1
> 
> And I'll be dropping it into linux-next for next week (iow, I'll commit
> it tomorrow.)
> 
> Unfortunately, -rc1 broke some platforms, so Olof's builder isn't going
> to get full coverage of it while building only my tree.

FYI I sent a pull request for the omap related fixes earlier today. So
we should be good to go from that point of view for enabling rodata by
default for v4.6.

Regards,

Tony
