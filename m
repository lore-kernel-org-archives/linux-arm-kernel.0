From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 19 Nov 2013 12:51:37 +0100
Subject: ACPI vs DT at runtime
In-Reply-To: <20131119113557.GI5914@e106331-lin.cambridge.arm.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <20131115175241.GB27174@quad.lixom.net>
 <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
 <20131119113557.GI5914@e106331-lin.cambridge.arm.com>
Message-ID: <20131119115137.GC22634@rocoto.smurfnet.nu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 11:35:57AM +0000, Mark Rutland wrote:
> > The UEFI spec pulls in portions of ACPI. I do not know the full extent
> > of the interaction between the two, but I know that they are not
> > completely decoupled. As you have pointed out we are not experienced
> > with ACPI or UEFI, so I don't think we can make statements that one is
> > perfectly fine without the other.
> 
> Given Leif's comments it seems that they are decoupled sufficiently to
> be considered separately.

Well, UEFI should be considered separately from ACPI.

I am not convinced it makes sense to consider ACPI for any case that
does not also include UEFI.

/
    Leif
