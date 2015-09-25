From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Sep 2015 13:06:03 +0100
Subject: Steps to submit a new arch/arm port
In-Reply-To: <56051393.2080709@free.fr>
References: <56001B78.2090001@free.fr> <2206647.QPrIpE2UC0@wuerfel>
 <56051393.2080709@free.fr>
Message-ID: <20150925120602.GL21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 11:27:47AM +0200, Mason wrote:
> On an unrelated topic, someone wrote
> select CPU_USE_DOMAINS if MMU
> in my platform Kconfig.

No platform config should *ever* touch that symbol.

> Is this an obsolete feature that I should remove?

It's not obsolete as such - but it's something that no ARMv6 or ARMv7
CPU should ever see set, and certainly something that platforms have
no business what so ever mucking around with.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
