From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Feb 2016 11:32:04 +0000
Subject: [PATCH 07/11] ARM: dts: sunxi: Add dtsi file for AXP809 PMIC
In-Reply-To: <CAGb2v66a=LLMBEbrR2qCzuYp+-fa96qLROFN10+aNvfGTtW-Zg@mail.gmail.com>
References: <1454408864-24112-1-git-send-email-wens@csie.org>
 <1454408864-24112-8-git-send-email-wens@csie.org>
 <20160202121733.GO4455@sirena.org.uk>
 <CAGb2v657zYT30KbuK0fyVOmhv0kzJjj9gTsTFRaS4i3d6YhiHQ@mail.gmail.com>
 <20160208145347.GD7265@sirena.org.uk>
 <CAGb2v64ySLAVbPf_XaZnzm5T=SmQLip4iO2p4cGXg=C0=51eqA@mail.gmail.com>
 <20160208162244.GG7265@sirena.org.uk>
 <CAGb2v66a=LLMBEbrR2qCzuYp+-fa96qLROFN10+aNvfGTtW-Zg@mail.gmail.com>
Message-ID: <20160209113204.GC13270@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2016 at 01:41:37PM +0800, Chen-Yu Tsai wrote:
> On Tue, Feb 9, 2016 at 12:22 AM, Mark Brown <broonie@kernel.org> wrote:

> > The whole point with constraints is that they describe what is safe on a
> > given board.  This includes powering off unused regulators - it should
> > be something that the system integrator configures, not something that
> > they get as default.

> OK. So how should one describe a regulator as unused? Just leave it out
> since it's not wired to anything? Or have an empty node at the board
> level? One of the regulators involved on my board is by (hardware)
> default on.

Like I say do it at the board level, you know it's not connected on that
board but another board may use it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/a5356163/attachment.sig>
