From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 7 Mar 2014 14:59:04 -0800
Subject: [PATCH RFC v2 08/11] tty: xuartps: Rename Kconfig symbols
In-Reply-To: <20140307213058.702ff194@alan.etchedpixels.co.uk>
References: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
 <1394219614-3197-9-git-send-email-soren.brinkmann@xilinx.com>
 <20140307213058.702ff194@alan.etchedpixels.co.uk>
Message-ID: <a588bea6-d402-4a87-ada0-cdf13f13ba59@CH1EHSMHS033.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-03-07 at 09:30PM +0000, One Thousand Gnomes wrote:
> On Fri,  7 Mar 2014 11:13:31 -0800
> Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:
> 
> > Rename the config symbols for the Cadence UART to reflect the driver
> > rebranding:
> >   SERIAL_XILINX_PS_UART(_CONSOLE) -> SERIAL_CADENCE_UART(_CONSOLE)
> 
> This breaks all those setups people have with pre-packed .config files
> that have worked for a long time and now randomly need changing for this
> kernel.

And this will be dropped as well.

	Thanks,
	S?ren
