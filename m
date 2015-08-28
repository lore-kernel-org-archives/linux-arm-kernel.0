From: broonie@kernel.org (Mark Brown)
Date: Fri, 28 Aug 2015 17:51:32 +0100
Subject: [PATCH] arm: tegra: update default configuration
In-Reply-To: <986a8cee-f090-4888-91f2-7b564c4b3d1d@email.android.com>
References: <986a8cee-f090-4888-91f2-7b564c4b3d1d@email.android.com>
Message-ID: <20150828165132.GQ12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 28, 2015 at 05:41:43AM +0000, Marcel Ziswiler wrote:

Please fix your mailer to word wrap within paragraphs so that your mails
are legible.

> On 27 Aug 2015 16:55, Mark Brown <broonie@kernel.org> wrote:

> > Does the system really have the wm9712 wired up as a battery monitor?

> Well, remember we are talking about a system on module. Those WM9712
> pins all go to the 200 pin SODIMM edge connector and I know that
> certain customers indeed have carrier boards that use it that way. If
> there is any opposition and considering this being rather optional I
> may also drop this one but audio/touch is definitely a standard
> feature available on all or carrier boards.

Does that actually work with mainline?  The driver requires platform
data to do anything useful (there's no DT bindings for it) and I can't
see anything providing that on Tegra systems.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150828/93e25501/attachment.sig>
