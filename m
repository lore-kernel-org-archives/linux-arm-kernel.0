From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Jun 2015 20:35:31 +0100
Subject: [PATCH] arm: cmpxchg: update macro to prevent compiler warning
In-Reply-To: <1434559056-20558-1-git-send-email-andre.przywara@arm.com>
References: <1434559056-20558-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20150617193531.GX7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 05:37:36PM +0100, Andre Przywara wrote:
> In kernel/acct.c we call the cmpxchg() macro without using it's
> return value, so the compiler complains when compiling for ARM:

A fix is already queued, and has been queued since 26th May.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
