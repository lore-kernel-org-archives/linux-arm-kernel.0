From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 18 Apr 2011 18:07:52 +0100
Subject: since when does ARM map the kernel memory in sections?
In-Reply-To: <20110418135243.GB1479@ucw.cz>
References: <201104122052.17453.pwaechtler@mac.com>
	<BANLkTin0NMo7ZDrnTmBghYeRC9wxJu7zrw@mail.gmail.com>
	<20110412203303.GA16019@shareable.org>
	<20110418135243.GB1479@ucw.cz>
Message-ID: <20110418170752.GQ16019@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Machek wrote:
> ...but note that no existing  filesystem is safe on media such
> as usb sticks, SD and CF cards...

Sadly.  Do you know by now if enough information is available now to
make it possible even in principle?

Alternatively, do you know if there's been much progress
characterising particular manufacturers/parts/brands or identifiable
characteristics etc. to find ones on which a power fail safe
filesystem is possible, even if it's just in principle for the moment?

Sadly I know of a large number of systems using CF or cheap ATA SSDs
that were installed assuming ext3 is reliable when they are powered
off at the wall every day.  That's because a lot of people assume they
are solid-state drop-in replacements for hard disks, as that is how
they are advertised.

-- Jamie
