From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Jan 2011 10:47:47 +0000
Subject: [PATCH 2.6.37 RESEND] sa1100: Fix platform device registration
In-Reply-To: <1293472170-14130-1-git-send-email-jochen@scram.de>
References: <1293472170-14130-1-git-send-email-jochen@scram.de>
Message-ID: <20110103104747.GG26785@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 27, 2010 at 06:49:30PM +0100, Jochen Friedrich wrote:
> Since commit 7a5b4e16c880f8350d255dc188f81622905618c1, simpad devices don't
> boot anymore, since platform devices are registered too early. Fix by moving
> the registration from map_io to arch_initcall as done on other sa1100 boards.

Please send to the patch system, thanks.
