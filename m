From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Jun 2013 00:24:14 +0200
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <201306130020.30437.arnd@arndb.de>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130612220250.GA14852@obsidianresearch.com>
 <201306130020.30437.arnd@arndb.de>
Message-ID: <201306130024.14368.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 June 2013, Arnd Bergmann wrote:

> Yes, I realize that, which is why I said it depends on the actual sizes.
> If you have a lot of windows that are all the same size and nothing larger,
> the worst case isn't too bad.

Also, if the available space is a naturally aligned address range with a
power-of-two size itself, the order does not matter at all and any order
is as good as any other.

	Arnd
