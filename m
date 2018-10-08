From: evgsyr@gmail.com (Eugene Syromyatnikov)
Date: Mon, 8 Oct 2018 20:33:37 +0200
Subject: ARM: Call syscall_trace_exit even when system call skipped
In-Reply-To: <20181008181341.GK30658@n2100.armlinux.org.uk>
References: <20180203152112.2449-1-T.E.Baldwin99@members.leeds.ac.uk>
 <20181008110047.GA3426@asgard.redhat.com>
 <CAGXu5jK1Jkxg6gkOV9GqW4FE96UNoOaG3-f5JVq6h9gnk53ohg@mail.gmail.com>
 <20181008181341.GK30658@n2100.armlinux.org.uk>
Message-ID: <20181008183336.GA17634@obsidian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 07:13:42PM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 08, 2018 at 11:08:16AM -0700, Kees Cook wrote:
> > Did this actually make it into the patch tracker? I don't see it in Incoming...
> 
> No, rejected at SMTP time (so bounced) due to it being sent from a
> gmail.com address but _not_ going through gmail servers (so no DKIM
> signature.)  Hence, looks like all the other fake gmail crud and gets
> rejected outright.
> 
> I guess if Eugene didn't get the bounce notification, then gmail
> decided to discard that as fake too!

My apologies, I've mixed up two systems with different mail client setups.
