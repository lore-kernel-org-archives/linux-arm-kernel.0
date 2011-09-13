From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Sep 2011 13:23:17 -0700
Subject: [PATCH 01/25] ARM: mm: Add strongly ordered descriptor support.
In-Reply-To: <1315144466-9395-2-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20110913202317.GE24252@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110904 06:22]:
> On certain architectures, there might be a need to mark certain
> addresses with strongly ordered memory attributes to avoid ordering
> issues at the interconnect level.

This is something Russell needs to look.

You might want to also read the mailing list archives regarding the
strongly ordered access.

Basically it still won't guarantee that the write gets to the
device, only a read back from the device in question guarantees
that at the bus level.

Regards,

Tony 
