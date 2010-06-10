From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 10 Jun 2010 09:00:23 +0200
Subject: usb gadget on zaurus and kexec
In-Reply-To: <AANLkTilCvgvf9Ch55f878nTNTue8tHYmcrLEywsjnylY@mail.gmail.com>
References: <20100519154618.GA26381@atrey.karlin.mff.cuni.cz>
	<AANLkTim49akRJK0BN_Qk1wL6e5mrdjZioDjGNWlrjUVQ@mail.gmail.com>
	<AANLkTilCvgvf9Ch55f878nTNTue8tHYmcrLEywsjnylY@mail.gmail.com>
Message-ID: <201006100900.23981.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 10. ?ervna 2010 08:10:22 Eric Miao napsal(a):
> On Thu, May 20, 2010 at 1:05 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> > On Wed, May 19, 2010 at 11:46 PM, Cyril Hrubis <metan@ucw.cz> wrote:
> >> Hi!
> >> After some testing I found out that no usb gadget (g_ether,
> >> g_mass_storage, ...) is working after zaurus boots with kexec. So it
> >> seems like some missing initalization (it's working after doing reboot
> >> again) anybody has any clue, patch or ideas how to debug this?
> > 
> > Dumping out the registers of the two situations and doing a comparison
> > then might be a quick way.
> 
> Any debugging update on this?

Yeah, there's a workaround. Cyril's working on a proper fix, but that might take 
some time. Simply -- UP2OCR is misconfigured.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
