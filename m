From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Sat, 11 Jun 2011 12:38:07 +0200
Subject: [PATCH 2/3] ts72xx: use MTDPART_OFS_RETAIN for mtd partitioning
In-Reply-To: <20110611092224.GB16318@ibawizard.net>
References: <1307369056-29319-1-git-send-email-dbaryshkov@gmail.com>
	<1307369056-29319-3-git-send-email-dbaryshkov@gmail.com>
	<20110611092224.GB16318@ibawizard.net>
Message-ID: <20110611103807.GC16318@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr ?tetiar <ynezz@true.cz> [2011-06-11 11:22:24]:

> I think, that it would be better to either make that Redboot partition
> read-only by default

Sorry for the noise, it's read-only already, I've just missed that mask.

-- ynezz
