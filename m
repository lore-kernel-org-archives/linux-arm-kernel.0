From: broonie@kernel.org (Mark Brown)
Date: Fri, 1 Sep 2017 17:23:22 +0100
Subject: Applied "regulator: pbias: Select voltage table based on
 max-voltage" to the regulator tree
In-Reply-To: <CAPDyKFo=UdnVhFU7k+K1=N0e-1sniC+WZjZ4dZKSF8mXhM43Uw@mail.gmail.com>
References: <E1dnO3z-0000tI-7K@debutante>
 <64d9c623-456c-9142-9c5b-a94593628643@ti.com>
 <20170831135050.adiek6iqqzhndgci@sirena.org.uk>
 <CAPDyKFo=UdnVhFU7k+K1=N0e-1sniC+WZjZ4dZKSF8mXhM43Uw@mail.gmail.com>
Message-ID: <20170901162322.xrjnim4khn3wfslj@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 01, 2017 at 03:18:03PM +0200, Ulf Hansson wrote:
> On 31 August 2017 at 15:50, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Aug 31, 2017 at 05:37:34PM +0530, Kishon Vijay Abraham I wrote:

> >> This patch should be merged along with the 1st patch of the series "mmc: host:
> >> omap_hsmmc: Remove setting PBIAS voltage". Or else it'll break MMC with
> >> omap_hsmmc driver.

Hang on, how can this break anything?  If it breaks things shouldn't
there be bugfixes for incorrect constraints somewhere?

> > I can sign a tag if it's needed for a cross tree merge.

> Easier if you could drop it and instead just provide an ack.

> Unless you believes there may conflict in your regulator tree?

My main goal is to get it in during this merge window, this way either
it goes in via my tree and the rest of the series can go in the next
release or the whole thing makes this merge window.

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-pbias-variants

for you to fetch changes up to 27eae9d4b9d4cd9c204ef81f46078d91362ed41c:

  regulator: pbias: Select voltage table based on max-voltage (2017-08-31 11:55:40 +0100)

----------------------------------------------------------------
regulator: Add support for different OMAP variants in the pbias regulator

----------------------------------------------------------------
Ravikumar Kattekola (1):
      regulator: pbias: Select voltage table based on max-voltage

 drivers/regulator/pbias-regulator.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170901/e81509a3/attachment.sig>
