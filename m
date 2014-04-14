From: moore@free.fr (Chris Moore)
Date: Mon, 14 Apr 2014 04:19:22 +0200
Subject: [PATCH 23/29] ARM: orion5x: use DT to describe NOR on edmini_v2
In-Reply-To: <534B4397.2000500@free.fr>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-24-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140413153150.GD10033@lunn.ch> <20140413174513.2e39a55c@skate>
 <534B4397.2000500@free.fr>
Message-ID: <534B45AA.90900@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, my first sentence should have read:
I subsequently added a fixup to drivers/mtd/chips/cfi_cmdset_0002.c to 
correct top/bottom detection for many Macronix devices including the 
MX29LV400CBCT.
