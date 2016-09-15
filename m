From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 15 Sep 2016 16:56:04 +0200
Subject: [PATCH v2 6/8] ARM: dts: sun9i: a80-optimus: Add AXP806 PMIC
 device node and regulators
In-Reply-To: <CAGb2v65cQR9F1=0_9mM6guKrMhOX7TqMqfHJU5hJxUXtBZiYaw@mail.gmail.com>
References: <20160827075544.26316-1-wens@csie.org>
 <20160827075544.26316-7-wens@csie.org>
 <CAGb2v65cQR9F1=0_9mM6guKrMhOX7TqMqfHJU5hJxUXtBZiYaw@mail.gmail.com>
Message-ID: <20160915145604.GJ10128@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 10:33:50PM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> On Sat, Aug 27, 2016 at 3:55 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> > The AXP806 PMIC is the secondary PMIC. It provides various supply
> > voltages for the SoC and other peripherals. The PMIC's interrupt
> > line is connected to NMI pin of the SoC.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> 
> The driver patches have all been merged into the mfd tree. Could
> you queue up the dts patches?

I just did.

Thanks for the remainder,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160915/7d725958/attachment.sig>
