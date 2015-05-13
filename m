From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 May 2015 16:32:46 +0100
Subject: [PATCH] RFC: mmc: core: Increase delay for voltage to stabilize
 from 3.3V to 1.8V
In-Reply-To: <CAPDyKFpkLhC7k+HNCYV_U7M6B615o4RgFktJ1wCXd_SxT0xiQg@mail.gmail.com>
References: <1431467171-12937-1-git-send-email-dianders@chromium.org>
 <20150513110915.GG3066@sirena.org.uk>
 <CAPDyKFpkLhC7k+HNCYV_U7M6B615o4RgFktJ1wCXd_SxT0xiQg@mail.gmail.com>
Message-ID: <20150513153246.GY2761@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 03:06:47PM +0200, Ulf Hansson wrote:
> On 13 May 2015 at 13:09, Mark Brown <broonie@kernel.org> wrote:

> > Right, and this is probably going beyond the delays that the regulator
> > API is handling since it's not something the regulator hardware is
> > actively managing.

> Thanks for elaborating from the regulator perspective. So may I apply
> your ack for this one?

I guess, yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/4d48f715/attachment.sig>
