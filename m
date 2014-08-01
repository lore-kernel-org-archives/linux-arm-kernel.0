From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 1 Aug 2014 18:15:57 +0200
Subject: [PATCH/RFC V8 1/1] clk: Support for clock parents and rates
 assigned from device tree
In-Reply-To: <20140725214231.5177.86866@quantum>
References: <1403105372-30403-1-git-send-email-s.nawrocki@samsung.com>
 <1403105372-30403-2-git-send-email-s.nawrocki@samsung.com>
 <53B59221.5080100@samsung.com> <20140725214231.5177.86866@quantum>
Message-ID: <20140801161557.GA3277@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 02:42:31PM -0700, Mike Turquette wrote:
> Quoting Sylwester Nawrocki (2014-07-03 10:25:53)
> > On 18/06/14 17:29, Sylwester Nawrocki wrote:
> > > This patch adds helper functions to configure clock parents and rates
> > > as specified through 'assigned-clock-parents', 'assigned-clock-rates'
> > > DT properties for a clock provider or clock consumer device.
> > > The helpers are now being called by the bus code for the platform, I2C
> > > and SPI busses, before the driver probing and also in the clock core
> > > after registration of a clock provider.
> > > 
> > > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> > 
> > Could someone please take a look and review that patch ?
> > Any further suggestions, ACKs/NAKs ?
> 
> Patch looks good to me. I'm happy to take it.
> 
> > 
> > I would appreciate a DT, SPI or the I2C maintainer opinions.
> 
> Yes, Acks from SPI and I2C maintainers would be good. I might need to
> drop those parts of this patch if they don't come through :-(

For the I2C part:

Acked-by: Wolfram Sang <wsa@the-dreams.de>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140801/12daccbb/attachment.sig>
