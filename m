From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 18 Apr 2011 13:17:35 -0400 (EDT)
Subject: since when does ARM map the kernel memory in sections?
In-Reply-To: <20110418170752.GQ16019@shareable.org>
References: <201104122052.17453.pwaechtler@mac.com>
	<BANLkTin0NMo7ZDrnTmBghYeRC9wxJu7zrw@mail.gmail.com>
	<20110412203303.GA16019@shareable.org> <20110418135243.GB1479@ucw.cz>
	<20110418170752.GQ16019@shareable.org>
Message-ID: <alpine.LFD.2.00.1104181313280.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Apr 2011, Jamie Lokier wrote:

> Pavel Machek wrote:
> > ...but note that no existing  filesystem is safe on media such
> > as usb sticks, SD and CF cards...
> 
> Sadly.  Do you know by now if enough information is available now to
> make it possible even in principle?
> 
> Alternatively, do you know if there's been much progress
> characterising particular manufacturers/parts/brands or identifiable
> characteristics etc. to find ones on which a power fail safe
> filesystem is possible, even if it's just in principle for the moment?

Have a look at:

https://wiki.linaro.org/WorkingGroups/Kernel/Projects/FlashCardSurvey


Nicolas
