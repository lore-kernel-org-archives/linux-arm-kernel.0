From: broonie@kernel.org (Mark Brown)
Date: Mon, 20 Mar 2017 11:38:17 +0000
Subject: [PATCH v3 5/5] ARM: dts: sun8i: Update audio-routing with
 renamed widgets
In-Reply-To: <20170318075509.3836-6-mylene.josserand@free-electrons.com>
References: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
 <20170318075509.3836-6-mylene.josserand@free-electrons.com>
Message-ID: <20170320113817.rcphcvrizi4yphhe@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 18, 2017 at 08:55:09AM +0100, Myl?ne Josserand wrote:
> The digital AIF interfaces has been renamed in the sun8i audio codec
> driver so the audio-routing in the device tree must be renamed too.

Given that these are fixes it probably makes sense that they all go in
together, can I get some acks for this and I'll apply it?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/80765819/attachment.sig>
