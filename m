From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Oct 2013 10:44:45 -0700
Subject: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT support.
In-Reply-To: <CAHCPf3vHWt5XJCwvGDMfX9rTPKqHU43SHORqpxLtLaDL6RGb8A@mail.gmail.com>
References: <1382616832-23593-1-git-send-email-denis@eukrea.com>
 <1382616832-23593-2-git-send-email-denis@eukrea.com>
 <20131025191513.5345BC4042C@trevor.secretlab.ca>
 <20131026114840.GX2443@sirena.org.uk>
 <CAHCPf3vHWt5XJCwvGDMfX9rTPKqHU43SHORqpxLtLaDL6RGb8A@mail.gmail.com>
Message-ID: <20131029174445.GB20251@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 11:56:54AM -0500, Matt Sealey wrote:

> Maybe this is a reasonable place to ask since I am holding off on
> doing any audio support for the i.MX platform I want to push a DT for,
> and I am still bashing my head over the logic in this. Why is this so
> much more complicated than it needs to be? I can see codec specific
> and Linux-specific things floating in trees. I can see redundancy in
> property naming and misplacement of properties.. this whole thing
> needs to be cleaned up because it's been done as "binding a Linux
> driver into the device tree" and this is another example of the same
> thing - taking the way ASoC is working right now and dumping platform
> data externally.

Can you be more specific about all these points please?  It's hard to
engage without concrete technical discussion which there is very little
of in your rather lengthy mail.  Please also take a look at the previous
discussions on this stuff and make sure you understand the needs of more
advanced audio subsystems like those found in smartphones.

> should not be codec or platform specific at all. This is a TI audio
> codec being referenced in an SoC-specific audio fabric definition.

Please take a look at Morimoto-san's work on the generic sound card if
you want to work on a generic card, it'd be good if some of the people
complaining about this stuff could help him work on that as he doesn't
seem to be getting any help or review from anyone.  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131029/a4a4f78d/attachment.sig>
