From: balbi@ti.com (Felipe Balbi)
Date: Tue, 2 Oct 2012 16:44:02 +0300
Subject: [PATCHv3 1/4] mfd: smsc: Add support for smsc gpio io/keypad
 driver
In-Reply-To: <20121002125819.GY4360@opensource.wolfsonmicro.com>
References: <1349089282-22105-1-git-send-email-sourav.poddar@ti.com>
 <CAAe_U6+zEGuwMC1yn7O=LXE6PhPvPc2i7DCF0EAprkE8s+-iEw@mail.gmail.com>
 <20121001114454.GA9170@sirena.org.uk>
 <CAAe_U6JX9QDWvWA3KH7E9sOv0EHGkozVONuXDgn+a2MZ4GTE7Q@mail.gmail.com>
 <20121001120907.GK4360@opensource.wolfsonmicro.com>
 <CAAe_U6K6nAjsZUOk2rBFweWHtJmcLF7EJDpu9O6FXrq3tzv3yg@mail.gmail.com>
 <20121002123856.GX4360@opensource.wolfsonmicro.com>
 <20121002124321.GD30762@arwen.pp.htv.fi>
 <20121002125819.GY4360@opensource.wolfsonmicro.com>
Message-ID: <20121002134400.GA12125@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 02, 2012 at 01:58:20PM +0100, Mark Brown wrote:
> On Tue, Oct 02, 2012 at 03:43:22PM +0300, Felipe Balbi wrote:
> 
> > BTW, OTOH writing all children into the DT actually describes the HW,
> > no ? And depending on the device I feel it'd be better to write that
> 
> Well, it depends on the hardware.  Some hardware has a bunch of nice,
> neat IPs which can usefully be reproduced and which map sensibly onto OS
> abstractions but a lot of it doesn't and frequently the abstractions
> which Linux wants to use don't bear a huge resemblance to the hardware
> (and Linux's ideas can change over time, as with the clock API being
> factored out for example).
> 
> > data to DT. Think of twlxxxx (TI's PMICs), we might have completely
> > unrelated drivers using one of TWL's GPIO lines as an interrupt source.
> 
> > If that particular children isn't listed in DT, it can't be used as an
> > interrupt-parent, right ?
> 
> You can have the interrupt controller there without having to list every
> IP in the device, just make the parent device the interrupt controller
> to DT.

fair enough, thanks ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121002/af2ffe1c/attachment.sig>
