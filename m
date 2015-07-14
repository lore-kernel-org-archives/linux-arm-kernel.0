From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Jul 2015 12:08:19 +0100
Subject: [RFC PATCH 14/15] regulator: pwm: implement ->enable(),
 ->disable() and ->is_enabled methods
In-Reply-To: <20150714130222.1bdfedc5@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-15-git-send-email-boris.brezillon@free-electrons.com>
 <20150714105019.GR11162@sirena.org.uk>
 <20150714130222.1bdfedc5@bbrezillon>
Message-ID: <20150714110819.GU11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 01:02:22PM +0200, Boris Brezillon wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > On Wed, Jul 01, 2015 at 10:22:00AM +0200, Boris Brezillon wrote:
> > > Implement the ->enable(), ->disable() and ->is_enabled methods and remove
> > > the PWM call in ->set_voltage_sel().

> > This doesn't apply, please check and resend.

> This series was made on top of Linus' tree (4.2-rc1 IIRC) and patch 14
> and 15 were not meant to be applied without Thierry's approval (they
> depend on other changes in the PWM framework).
> I can rebase them on top of linux-next (or just on top of Linus'
> 4.2-rc2) if Thierry is okay with that, but I don't think rebasing them
> on your regulator's for-next branch is a good idea.

What is the dependency for the enable patch?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150714/257aec9f/attachment.sig>
