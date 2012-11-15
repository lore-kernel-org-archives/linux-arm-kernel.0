From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Nov 2012 13:36:23 +0000
Subject: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
In-Reply-To: <CACY+gR3PurUofCbUeG40B6vXqXAoHrMmbOQSuwAGoc1LS8XXJQ@mail.gmail.com>
References: <20121114185335.GU6801@atomide.com> <50A3EBCD.3040801@ti.com>
 <20121114202244.GE3332@n2100.arm.linux.org.uk>
 <20121114203221.GA6801@atomide.com> <50A413D4.7000405@gmail.com>
 <20121114222159.GB6801@atomide.com> <50A43D58.5030404@gmail.com>
 <20121115110137.GA25985@arm.com>
 <CACY+gR3PurUofCbUeG40B6vXqXAoHrMmbOQSuwAGoc1LS8XXJQ@mail.gmail.com>
Message-ID: <20121115133623.GG3332@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 02:41:43PM +0200, Siarhei Siamashka wrote:
> BTW, I always wondered about what could be preventing TI and the other
> silicon vendors from using something like an SMC API based on
> asymmetric cryptography?

The answer is... nothing.  But it didn't happen and we're stuck with the
consequences of that.
