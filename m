From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 19 Sep 2011 10:01:34 +0100
Subject: [RFC v3] arm: Add platform bus driver for memory mapped virtio
	device
In-Reply-To: <874o09ryzm.fsf@rustcorp.com.au>
References: <1316191623-3835-1-git-send-email-pawel.moll@arm.com>
	<4E7380FD.1030200@us.ibm.com>  <874o09ryzm.fsf@rustcorp.com.au>
Message-ID: <1316422894.3014.1.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Have you written a specification for this device?
> > 
> > Rusty maintains a formal spec for all virtio devices at:
> > 
> > http://ozlabs.org/~rusty/virtio-spec/
> > 
> > The spec should be written before merging the code to make sure that there 
> > aren't future compatibility problems.
> 
> A good idea, but the current spec is for PCI.  I wonder if we should
> move the PCI part out to an appendix and make it more general?
> 
> Meanwhile, perhaps this would be suitable as an appendix.

Yes, that sounds reasonable. I'll work on this during the week, but in
the meantime - does the driver look good enough to ask Peter to invest
his time into QEMU side?

Cheers!

Pawe?
