From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 16 Feb 2013 23:25:50 +0000
Subject: [PATCH 02/11] ARM: samsung: fix assembly syntax for new gas
In-Reply-To: <1360849767-1463135-3-git-send-email-arnd@arndb.de>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
 <1360849767-1463135-3-git-send-email-arnd@arndb.de>
Message-ID: <20130216232550.GQ17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 02:49:18PM +0100, Arnd Bergmann wrote:
> Recent assembler versions complain about extraneous
> whitespace inside [] brackets. This fixes all of
> these instances for the samsung platforms. We should
> backport this to all kernels that might need to
> be built with new binutils.

I hope that's also been reported as a bug to the binutils people.
