From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2011 14:56:57 +0000
Subject: [PATCH 01/51] ARM: reset: introduce arm_arch_reset function
	pointer
In-Reply-To: <CAH+eYFD_XPgbvp828q7508TOPNdP4TK7wiej2aBhPb18WbQ+Eg@mail.gmail.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-2-git-send-email-will.deacon@arm.com>
	<20111029102108.GY19187@n2100.arm.linux.org.uk>
	<20111029135653.GA25057@mudshark.cambridge.arm.com>
	<20111031141322.GK19187@n2100.arm.linux.org.uk>
	<CAH+eYFDM_spE8jg4K5awBPZvPyEmdhSnQ9Zt=v2U4PmFQeRLOw@mail.gmail.com>
	<20111031143904.GM19187@n2100.arm.linux.org.uk>
	<CAH+eYFD_XPgbvp828q7508TOPNdP4TK7wiej2aBhPb18WbQ+Eg@mail.gmail.com>
Message-ID: <20111031145657.GN19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2011 at 08:14:14PM +0530, Rabin Vincent wrote:
> On Mon, Oct 31, 2011 at 20:09, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Oct 31, 2011 at 08:03:26PM +0530, Rabin Vincent wrote:
> >> The above patch will apply with gnu patch if you use -p0.
> >
> > $ patch -p0 -i arch_reset-1.diff --dry-run
> > patch: **** rejecting absolute target file name: /tmp/cocci-output-380-f841cc-system.h
> 
> Works for me, maybe a version difference?

Same version.  Some versions have become anal about security - and the
one in Fedora seems to be that.
