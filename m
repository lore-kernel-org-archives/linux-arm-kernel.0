From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Feb 2011 16:25:16 +0000
Subject: [PATCH v2] ARM: Define wfi() macro for v6 processors
In-Reply-To: <201102081615.15713.arnd@arndb.de>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<201102081353.20390.arnd@arndb.de>
	<AANLkTi=+2VN53gs=ZDr-M0V3mG5A0iMPRL-RdUugXxUy@mail.gmail.com>
	<201102081615.15713.arnd@arndb.de>
Message-ID: <20110208162515.GB6188@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 08, 2011 at 04:15:15PM +0100, Arnd Bergmann wrote:
> But that doesn't work if you build a combined v5/v6/v7 kernel, because
> v5 supports neither form, right? I think to do that, it needs the
> same kind of abstraction that we have for a number of other things
> like cache management in arch/arm/mm/.

The options are kernels which support v3-v5 or v6-v7.  There's too big
a change between v5 and v6 to combine those into one kernel.
