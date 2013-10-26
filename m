From: broonie@kernel.org (Mark Brown)
Date: Sat, 26 Oct 2013 12:48:40 +0100
Subject: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT support.
In-Reply-To: <20131025191513.5345BC4042C@trevor.secretlab.ca>
References: <1382616832-23593-1-git-send-email-denis@eukrea.com>
 <1382616832-23593-2-git-send-email-denis@eukrea.com>
 <20131025191513.5345BC4042C@trevor.secretlab.ca>
Message-ID: <20131026114840.GX2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 25, 2013 at 08:15:13PM +0100, Grant Likely wrote:
> On Thu, 24 Oct 2013 14:13:49 +0200, Denis Carikli <denis@eukrea.com> wrote:

> > +- mux-int-port : The internal port of the i.MX audio muxer (AUDMUX).
> > +- mux-ext-port : The external port of the i.MX audio muxer.

> > +Note: The AUDMUX port numbering should start at 1, which is consistent with
> > +hardware manual.

> Looks okay to me. I've not been following the sound bindings very
> closely. Are the described properties a common pattern for sound complex
> bindings?

They're standard for i.MX - it's a mux within the SoC.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131026/de21155e/attachment.sig>
