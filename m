From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 17:13:11 +0100
Subject: [GIT PULL 2/2] SOCFPGA DTS updates for v3.19
In-Reply-To: <1416283415-6563-2-git-send-email-dinguyen@opensource.altera.com>
References: <1416283415-6563-1-git-send-email-dinguyen@opensource.altera.com>
 <1416283415-6563-2-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <201411201713.11825.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 November 2014, dinguyen at opensource.altera.com wrote:
> SoCFPGA DTS updates for v3.19
> 
> - Add DTS support for a new chip in the SOCFPGA family, the Arria 10.
> - Enable watchdog node.
> - Add SPI nodes.
> - Add the OCRAM node.

The patches all look good, but I'd rather see them rebased on top of -rc1
so I can apply them without backmerging -rc4.

Let me know if you want me to cherry-pick the four patches or you
want to send an updated pull request.

	Arnd
