From: utx@penguin.cz (Stanislav Brabec)
Date: Mon, 29 Mar 2010 20:52:08 +0200
Subject: bit errors on spitz
In-Reply-To: <20100329182736.GA1373@ucw.cz>
References: <20100305212708.GC21773@elf.ucw.cz>
	<f17812d71003072137u51be17a1ie3e50e30dea16f77@mail.gmail.com>
	<20100308072858.GA29939@atrey.karlin.mff.cuni.cz>
	<20100308082530.GA1982@atrey.karlin.mff.cuni.cz>
	<4B98EF5D.5000609@warmcat.com>
	<1268322155.3990.114.camel@hammer.suse.cz>
	<4B995EE1.1050609@warmcat.com> <1268384824.4963.35.camel@utx.utx.cz>
	<20100321204335.GM1933@elf.ucw.cz>
	<1269207753.13196.53.camel@utx.utx.cz>
	<20100329182736.GA1373@ucw.cz>
Message-ID: <1269888728.3972.73.camel@hammer.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Machek wrote:

> > Alternatively, it is possible to write a driver. It is just one byte
> > write and one byte read via I2C.
> 
> Do you know what byte it is? That sounds easy enough...

Yes, it should be easy driver. One byte address and then one byte write
or one byte read.

See the datasheet:
http://www.penguin.cz/~utx/zaurus/datasheets/power/XScale/ISL6271A.pdf

Page 11: address
Pages 8 and 9: Data interpretation

-- 
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus
