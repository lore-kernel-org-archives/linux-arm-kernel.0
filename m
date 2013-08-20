From: broonie@kernel.org (Mark Brown)
Date: Tue, 20 Aug 2013 19:50:19 +0100
Subject: [alsa-devel] [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM
 links between codec and cpu DAI
In-Reply-To: <20130820133143.GC23006@n2100.arm.linux.org.uk>
References: <20130806133206.GA6427@sirena.org.uk>
 <20130810161123.GW23006@n2100.arm.linux.org.uk>
 <20130810211342.GX23006@n2100.arm.linux.org.uk>
 <1376293215.2385.32.camel@loki>
 <20130812082837.GB23006@n2100.arm.linux.org.uk>
 <1376405952.2617.101.camel@loki>
 <20130820102555.GZ23006@n2100.arm.linux.org.uk>
 <20130820114421.GN30073@sirena.org.uk>
 <20130820114949.GB23006@n2100.arm.linux.org.uk>
 <20130820133143.GC23006@n2100.arm.linux.org.uk>
Message-ID: <20130820185019.GP30073@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 02:31:43PM +0100, Russell King - ARM Linux wrote:

> Let's be a little more clear about that: I don't know how to do that
> because that's the approach taken by _these_ very patches which you've
> rejected for "abusing the ASoC core".  That's why I'm asking Liam

The patches I can recall seeing recently have all had some workarounds
in the core which would need to be resolved differently, though it's
possible I missed that being done in some version in your mails as there
have generally also been a lot of modifications adding debug statements
in the core.

If you've got code you think is in a good state to submit then please do
send it as a normal patch series, the last one I've got here has "ASoC:
HACK: avoid creating duplicated widgets" as part of it for example.

Just to be clear when I say either/or I'm talking about a DAI driver
that can either run in S/PDIF mode or run in I2S mode in a given machine
but not support both being hooked up in the same machine.  Obviously
this isn't the end goal but it might be a useful intermediate step if
you find you are are blocked. 

> Since you continue to refuse to take the patches, but haven't given any
> further reasons why, and I've shown your original objections to be
> provably false, you leave me no other options but to try and bypass

To reiterate please submit patches if you believe everything is OK now
and then let's go through and review them.

> you, especially when you have plainly stated that you don't care about
> Kirkwood stuff.

I think you'll find that anything I've said along those lines has been
in relation to your strongly worded requests for me to make changes for
you.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130820/2df5ad0d/attachment.sig>
