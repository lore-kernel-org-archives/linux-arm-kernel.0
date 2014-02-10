From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Feb 2014 23:01:02 +0100
Subject: [linux-sunxi] Re: [PATCH 3/3] mfd: axp20x: Add bindings
 documentation
In-Reply-To: <CAOQ7t2YBhUuVQuDhkCux4ogb8_W2Ja1RMn4+UtcUpYrR84Boug@mail.gmail.com>
References: <1391875428-6281-1-git-send-email-carlo@caione.org>
 <1391875428-6281-4-git-send-email-carlo@caione.org>
 <20140210201215.GC3192@lukather>
 <CAOQ7t2YBhUuVQuDhkCux4ogb8_W2Ja1RMn4+UtcUpYrR84Boug@mail.gmail.com>
Message-ID: <20140210220102.GG3192@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 09:37:37PM +0100, Carlo Caione wrote:
> >> +Sub-nodes
> >> +* regulators : Contain the regulator nodes. The regulators are bound using
> >> +            their name as listed here: dcdc2, dcdc3, ldo1, ldo2, ldo3,
> >> +            ldo4, ldo5.
> >> +            The bindings details of individual regulator device can be found in:
> >> +            Documentation/devicetree/bindings/regulator/regulator.txt with the
> >> +            exception of:
> >
> > I'm guessing this is where you differentiate between AXP202 and
> > AXP209?
> 
> Not really. AXP202 and AXP209 have the same regulators (with the same
> constrains)

Ok. What's the difference between the two then?

Thanks,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140210/7fcfc338/attachment.sig>
