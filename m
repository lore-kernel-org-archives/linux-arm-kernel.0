From: ijc@hellion.org.uk (Ian Campbell)
Date: Tue, 02 Sep 2014 18:06:44 +0100
Subject: Autoloading of SPI/nor driver on kirkwood (qnap devices)
In-Reply-To: <1409673299.14324.43.camel@dagon.hellion.org.uk>
References: <1409673299.14324.43.camel@dagon.hellion.org.uk>
Message-ID: <1409677604.14324.49.camel@dagon.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-09-02 at 16:54 +0100, Ian Campbell wrote:
> I could set these things to =m for the Debian kirkwood flavour, but
> since this is supposed to be a distro-style kernel.

(Oops, I somehow failed to insert "I would prefer not to" somewhere in
that sentence.)

But, looking at the Debian config a bit closer it seems like all this
stuff was previously =y for the kirkwood config and it's just that
things were refactored to add MTD_SPI_NOR. So I went with =y for that
too.

Still, it would be nice (tm) if these things would autoload when
modular.

Ian.
