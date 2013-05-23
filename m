From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 May 2013 21:26:43 +0100
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on
 Armada 370/XP
In-Reply-To: <20130523142301.10dbeff9@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
 <201305222240.05124.arnd@arndb.de> <20130523142301.10dbeff9@skate>
Message-ID: <20130523202643.GQ18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 02:23:01PM +0200, Thomas Petazzoni wrote:
> But that's *not* the case. Neither the old nor the new bootloaders are
> changing the Device Tree in any way that allows us to know whether
> registers are mapped at 0xd0 and 0xf1.

Who provides this DT blob?  Is it already provided with the board, or
is it something which is provided by others?
