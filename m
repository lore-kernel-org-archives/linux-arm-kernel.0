From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 4 Mar 2015 21:34:00 +0100
Subject: [PATCH] ARM: sun7i: dt: Add new MK808C device
In-Reply-To: <CAEKpxB=-vtjMckh3ZHoy0mezE9U1EtKzmttdXRD5ZNztZvB_ag@mail.gmail.com>
References: <1425131004-8551-1-git-send-email-codekipper@gmail.com>
 <20150303071342.GB4713@lukather>
 <CAEKpxB=-vtjMckh3ZHoy0mezE9U1EtKzmttdXRD5ZNztZvB_ag@mail.gmail.com>
Message-ID: <20150304203400.GR4911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 09:22:32PM +0100, Code Kipper wrote:
> >> +
> >> +/ {
> >> +     model = "mk808c";
> >> +     compatible = "mk808c", "allwinner,sun7i-a20";
> >
> > the compatible must be of the format "vendor,device". Please add the
> > vendor name.
> 
> Ahhh....I've searched high and low for a vendors name. I listed it as
> unknown on the wiki page,
> would 'odm' be considered valid?

Not really. Another mk808c device might very well be made by some
other odm.

Don't your device has any brand on the case or the PCB?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150304/7bf9b2c4/attachment.sig>
