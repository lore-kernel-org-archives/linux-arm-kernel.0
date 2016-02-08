From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Feb 2016 12:18:11 +0000
Subject: [PATCH 1/2] ARM: remove bzImage target
In-Reply-To: <1454907899-32101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1454907899-32101-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160208121810.GL10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 02:04:58PM +0900, Masahiro Yamada wrote:
> bzImage has been just an alias for zImage for more than a decade.
> It would not hurt to delete it.

NAK.  bzImage exists for compatibility with build scripts, removing it
is likely to break people's scripts.  It does no harm to keep it.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
