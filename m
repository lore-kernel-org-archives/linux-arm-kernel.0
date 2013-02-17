From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sun, 17 Feb 2013 16:37:44 +0100
Subject: [PATCH 02/11] ARM: samsung: fix assembly syntax for new gas
In-Reply-To: <20130216232550.GQ17833@n2100.arm.linux.org.uk>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
 <1360849767-1463135-3-git-send-email-arnd@arndb.de>
 <20130216232550.GQ17833@n2100.arm.linux.org.uk>
Message-ID: <20768.63816.104018.377650@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux writes:
 > On Thu, Feb 14, 2013 at 02:49:18PM +0100, Arnd Bergmann wrote:
 > > Recent assembler versions complain about extraneous
 > > whitespace inside [] brackets. This fixes all of
 > > these instances for the samsung platforms. We should
 > > backport this to all kernels that might need to
 > > be built with new binutils.
 > 
 > I hope that's also been reported as a bug to the binutils people.

See PR gas/14887, a post binutils-2.23.1 regression which seems
to be fixed on trunk but not on 2.23 branch.
