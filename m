From: liviu@dudau.co.uk (Liviu Dudau)
Date: Mon, 18 May 2015 23:31:32 +0100
Subject: [PATCH v2 0/5]  arm64: Juno DT updates and new DT for Juno R1
In-Reply-To: <4136868.8yCICAPH00@wuerfel>
References: <1431970109-8902-1-git-send-email-Liviu.Dudau@arm.com>
 <4136868.8yCICAPH00@wuerfel>
Message-ID: <20150518223132.GA946@bart.dudau.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 10:14:23PM +0200, Arnd Bergmann wrote:
> On Monday 18 May 2015 18:28:24 Liviu Dudau wrote:
> > This series restructures the Juno DT files and introduces the DT
> > for the new Juno R1. The board is an update of the Juno R0 with
> > support for PCIe, but the current series only brings the board to
> > parity with Juno R0. The series that enable the PCIe Generic Host
> > Bridge to be used on Juno R1 will be posted separately.
> > 
> > Changes from v1:
> >  - Moved memory node inside juno-base.dtsi as this is common between
> >    boards and unlikely to change soon.
> >  - Added "arm,juno-r1" as compatible string in juno-r1.dts at Jon Medhurst's
> >    suggestion.
> 
> Are you planning to send a pull request to arm at kernel.org for this when
> you're happy with the state, or should we pick up the patches from the
> list?

If I don't see any more comments in the next couple(?) of days then I will
send a pull request.

Many thanks,
Liviu

> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
