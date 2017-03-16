From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Mar 2017 14:06:53 +0000
Subject: Applied "ASoC: sun8i-codec: Update mixer to use SOC_DAPM_DOUBLE"
 to the asoc tree
In-Reply-To: <CAGb2v67-b+8CM0MqhT_YQeuNxEnVoxG-COZPy8LW32Eb-QE67Q@mail.gmail.com>
References: <20170210094133.11382-3-mylene.josserand@free-electrons.com>
 <E1clbY9-0000DH-LY@finisterre>
 <CAGb2v6428PpYPzpHngLgaeziwKN8u-TYiNO1bs7TFw-7VrQOAg@mail.gmail.com>
 <20170315134323.i3pvla3pzejmkxwh@sirena.org.uk>
 <CAGb2v67-b+8CM0MqhT_YQeuNxEnVoxG-COZPy8LW32Eb-QE67Q@mail.gmail.com>
Message-ID: <20170316140653.jjnta4le6kws36l5@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 10:15:22PM +0800, Chen-Yu Tsai wrote:

> It depends on the second half of commit 4aa8146c89f3 ("ASoC: sun8i-codec:
> Remove analog "HP" widget"), which is also a cleanup. Would it be OK
> to pick these two over to fixes then? Or should we send a clean version
> instead?

That also doesn't pick over cleanly, can you send a new version against
Linus' tree, that'll be easiest and safest I think.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170316/69d56a4b/attachment.sig>
