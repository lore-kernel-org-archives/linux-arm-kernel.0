From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Jun 2014 11:33:36 +0100
Subject: [PATCH 1/2] documentation: add rockchip spi documentation
In-Reply-To: <20140624101802.GE5856@leverpostej>
References: <1403582324-9485-1-git-send-email-addy.ke@rock-chips.com>
 <1403582324-9485-2-git-send-email-addy.ke@rock-chips.com>
 <20140624101802.GE5856@leverpostej>
Message-ID: <20140624103336.GG23300@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 11:18:02AM +0100, Mark Rutland wrote:
> On Tue, Jun 24, 2014 at 04:58:43AM +0100, addy ke wrote:

> > +- Board Specific Portion:
> > +
> > +	&spi0 {
> > +		status = "okay";
> > +		spi_test at 00 {
> > +			compatible = "rockchip,spi_test";

> Huh?

I expect that's just intended as an example of how to set up a device
and they're doing something like use a driver that generates known
patterns.  We'd normally omit such examples from the binding document
since it's generic and covered well enough elsehwere.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140624/cb899a85/attachment-0001.sig>
