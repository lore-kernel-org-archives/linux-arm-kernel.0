From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Feb 2015 00:35:49 +0000
Subject: [PATCH] net: smc91x: improve neponset hack
In-Reply-To: <5763365.j5Nvv4LgM3@wuerfel>
References: <5763365.j5Nvv4LgM3@wuerfel>
Message-ID: <20150219003549.GY8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 08:47:30PM +0100, Arnd Bergmann wrote:
> The smc91x driver tries to support multiple platforms at compile
> time, but they are mutually exclusive at runtime, and not clearly
> defined.

I'd prefer to rework this to fix that properly.  From what I remember,
the whole SA11x0 stuff in this driver was a mess.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
