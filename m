From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 27 Jun 2014 09:39:33 -0400
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.17
In-Reply-To: <53AD724D.4020704@gmail.com>
References: <20140627130129.GH23978@titan.lakedaemon.net>
 <20140627130430.GH32514@n2100.arm.linux.org.uk>
 <53AD724D.4020704@gmail.com>
Message-ID: <20140627133933.GJ23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Fri, Jun 27, 2014 at 03:31:57PM +0200, Sebastian Hesselbarth wrote:
> Also, production variants have their MAC address stored at 0xd0000 on
> SPI flash. And while ES has PL2303 USB-to-UART, production use a
> different brand, IIRC FTDI.

Could you do a follow on patch adding a comment to this effect?  The
Debian guys will need this for flash-kernel and friends.

thx,

Jason.
