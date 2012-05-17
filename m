From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 17 May 2012 19:35:12 -0400
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <4FB25A9A.3070306@gmail.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB228AD.5000507@codethink.co.uk> <4FB25A9A.3070306@gmail.com>
Message-ID: <20120517233512.GH16338@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 08:31:06AM -0500, Rob Herring wrote:
> marvell is the documented vendor string, not mrvl.

When Arnd and I were adding the initial kirkwood support for devicetree,
the common wisdom was to use the stock ticker symbol when available.
Hence, mrvl, iom, and dlink (only on taiwanese exchange, which uses
numbers)...

thx,

Jason.
