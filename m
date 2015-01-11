From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 11 Jan 2015 11:38:54 +0200
Subject: [PATCH v2 3/8] ARM: digicolor: add minimal device tree description
In-Reply-To: <20150109114624.GB12942@leverpostej>
References: <cover.1420744368.git.baruch@tkos.co.il>
 <9d8d7aed6220e9e92ab70217a65d3291924cfa71.1420744369.git.baruch@tkos.co.il>
 <20150109114624.GB12942@leverpostej>
Message-ID: <20150111093853.GN2481@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, Jan 09, 2015 at 11:46:24AM +0000, Mark Rutland wrote:
> On Thu, Jan 08, 2015 at 07:39:59PM +0000, Baruch Siach wrote:
> > cx92755.dtsi describes CX92755 on chip peripherals. conexant_equinox.dts
> > describes the Equinox evaluation board for the CX92755 SoC.
> 
> I didn't spot any cpu nodes below. While that might happen to work at
> the moment for UP, there really should be a node for the boot CPU.

OK. I'll add one in the next revision.

Thanks for reviewing.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
