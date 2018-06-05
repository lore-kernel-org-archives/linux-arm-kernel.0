From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 5 Jun 2018 16:50:38 +0200
Subject: [PATCH v2] arm: sun4i: Add support for Pengpod 1000 tablet
In-Reply-To: <313a74ea-0be6-cff1-6b2f-06a4b0b7ba8d@settrans.net>
References: <20180602160313.26763-1-rah@settrans.net>
 <20180604081302.hcn7j36gt6xeyquq@flea>
 <313a74ea-0be6-cff1-6b2f-06a4b0b7ba8d@settrans.net>
Message-ID: <20180605145038.qptdlcphdbnw6jyg@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 04, 2018 at 06:33:02PM +0100, Bob Ham wrote:
> On 04/06/18 09:13, Maxime Ripard wrote:
> > On Sat, Jun 02, 2018 at 05:03:13PM +0100, Bob Ham wrote:
> 
> >> + * This file is dual-licensed: you can use it either under the terms
> >> + * of the GPL or the X11 license, at your option. Note that this dual
> >> + * licensing only applies to this file, and not this project as a
> >> + * whole.
> 
> >> + *     The above copyright notice and this permission notice shall be
> >> + *     included in all copies or substantial portions of the Software.
> 
> > And this is redundant with the SPDX header.
> 
> The X11 license notice states explicitly that the notice has to be
> included in the file.  Wouldn't removing it be a violation of the license?

The SPDX header is explicitly here to remove the license text and
create a tag that is in a indirect reference to the license text in
LICENSES. It's not going away.

> >> +		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
> > 
> > Each step should increase the perceived brightness by roughly 1/Nth, N
> > being the number of steps. Usually PWM backlights don't work like that.
> 
> FYI, this was copied from another .dts file.  All of the other
> brightness-levels settings in sun{4,5,7}i .dts files follow similar
> patterns:
> 
> sun4i-a10-dserve-dsrv9703c.dts:               brightness-levels = <0 10
> 20 30 40 50 60 70 80 90 100>;
> sun4i-a10-inet1.dts:          brightness-levels = <0 10 20 30 40 50 60
> 70 80 90 100>;
> sun4i-a10-pov-protab2-ips9.dts:               brightness-levels = <0 10
> 20 30 40 50 60 70 80 90 100>;
> sun5i-a13-empire-electronix-d709.dts:         brightness-levels = <0 10
> 20 30 40 50 60 70 80 90 100>;
> sun5i-a13-utoo-p66.dts:       brightness-levels = <0 30 40 50 60 70 80
> 90 100>;
> sun5i-gr8-evb.dts:            brightness-levels = <0 10 20 30 40 50 60
> 70 80 90 100>;
> sun7i-a20-wexler-tab7200.dts:         brightness-levels = <0 10 20 30 40
> 50 60 70 80 90 100>;

I never said we were perfect reviewers. Feel free to help in the process.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180605/ec5e1ba7/attachment-0001.sig>
