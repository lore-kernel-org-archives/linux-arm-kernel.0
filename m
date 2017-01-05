From: tony@atomide.com (Tony Lindgren)
Date: Thu, 5 Jan 2017 07:36:38 -0800
Subject: [PATCH 1/6] ARM: dts: am335x-phycore-som: Update NAND partition
 table
In-Reply-To: <1483627851-17996-2-git-send-email-t.remmet@phytec.de>
References: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
 <1483627851-17996-2-git-send-email-t.remmet@phytec.de>
Message-ID: <20170105153637.GA4310@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Teresa Remmet <t.remmet@phytec.de> [170105 06:57]:
> To improve NAND safety we updated the partition layout.
> Added barebox backup partition and removed kernel and oftree
> partition. They are kept in ubi now.

What about the users with earlier partition tables?

Please read about "flag day" changes, typically they are not
acceptable.

Regards,

Tony
