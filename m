From: eduardo.valentin@nokia.com (Eduardo Valentin)
Date: Mon, 10 May 2010 13:33:19 +0300
Subject: [RESEND PATCHv3 0/4] Adding soc related info into /proc/cpuinfo
In-Reply-To: <20100505085932.GA7703@n2100.arm.linux.org.uk>
References: <1273048928-6105-1-git-send-email-eduardo.valentin@nokia.com>
	<20100505085932.GA7703@n2100.arm.linux.org.uk>
Message-ID: <20100510103319.GA8441@besouro.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

So, back to this track.

On Wed, May 05, 2010 at 10:59:32AM +0200, Russell King wrote:
> On Wed, May 05, 2010 at 11:42:04AM +0300, Eduardo Valentin wrote:
> > I'm resending this series with minor change in the subject prefix of patch 4/4.
> > Removed the PM: prefix. Everything else is same. So, I kept the v3 prefix as well.
> 
> I'd much prefer to see a /proc/socinfo rather than extending
> /proc/cpuinfo to further include stuff which isn't CPU related.


Right. I agree that this is not CPU stuff. But I was trying to do not add new interfaces
to export those bits.

But the socinfo is actually a nice idea. I will resend this series, but now it will create the
socinfo and use it.

As it adds new stuff under /proc, I'll also cc lkml.

Thanks for the suggestion.

BR,


--
Eduardo Valentin
