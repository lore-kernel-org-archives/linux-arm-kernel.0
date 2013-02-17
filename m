From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 17 Feb 2013 15:47:11 +0000
Subject: [PATCH 02/11] ARM: samsung: fix assembly syntax for new gas
In-Reply-To: <20768.63816.104018.377650@pilspetsen.it.uu.se>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
 <20130216232550.GQ17833@n2100.arm.linux.org.uk>
 <20768.63816.104018.377650@pilspetsen.it.uu.se>
Message-ID: <201302171547.11614.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 17 February 2013, Mikael Pettersson wrote:
> Russell King - ARM Linux writes:
>  > On Thu, Feb 14, 2013 at 02:49:18PM +0100, Arnd Bergmann wrote:
>  > > Recent assembler versions complain about extraneous
>  > > whitespace inside [] brackets. This fixes all of
>  > > these instances for the samsung platforms. We should
>  > > backport this to all kernels that might need to
>  > > be built with new binutils.
>  > 
>  > I hope that's also been reported as a bug to the binutils people.
> 
> See PR gas/14887, a post binutils-2.23.1 regression which seems
> to be fixed on trunk but not on 2.23 branch.

Ok, thanks for the info, I just came to the same conclusion a few minutes
before your reply.

Since I have some binutils people listening now, maybe someone can
comment on the issue I tried working around in
https://patchwork.kernel.org/patch/2013211/

	Arnd
