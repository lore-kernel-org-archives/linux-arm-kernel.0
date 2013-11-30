From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 30 Nov 2013 14:42:47 +0100
Subject: [RFC PATCH 1/3] iio: accel: Add device tree probing for STMicro
 accelerometers
In-Reply-To: <5299D444.30801@kernel.org>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
 <1384876234-1211-2-git-send-email-maxime.ripard@free-electrons.com>
 <5299D444.30801@kernel.org>
Message-ID: <20131130134247.GB3002@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 30, 2013 at 12:04:20PM +0000, Jonathan Cameron wrote:
> On 11/19/13 15:50, Maxime Ripard wrote:
> > Add the compatibles supported by the st_sensors library. This uses kind
> > of a hack, since the st_sensors core will actively check at probe time
> > that the device name matches the one reported when using old style i2c
> > probing, and that this name will be different with device tree.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> Note that this is unnecessary give core i2c matching, until we have some
> more elements in the binding.  I'd certainly expect the interrupts
> on the relevant devices to be in the binding...

This interrupt DT thing has been stalled for monthes, I don't have any
hardware to test the interrupts, maybe we can just move forward and
wait for someone that have the need for the interrupts to do the work?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131130/6d5ab51c/attachment.sig>
