From: andi@firstfloor.org (Andi Kleen)
Date: Wed, 16 Sep 2015 04:55:46 +0200
Subject: [PATCH 0/3] Add __ioread32_copy() and use it
In-Reply-To: <20150915195031.0a1756a2.akpm@linux-foundation.org>
References: <1442346089-32077-1-git-send-email-sboyd@codeaurora.org>
 <20150915155815.5a41a8dc537610ab44d8d3dc@linux-foundation.org>
 <20150916023219.GD1747@two.firstfloor.org>
 <20150915195031.0a1756a2.akpm@linux-foundation.org>
Message-ID: <20150916025546.GE1747@two.firstfloor.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Under what circumstances will the compiler (or linker?) do this? 

Compiler.

> LTO enabled?

Yes it's for LTO.  The optimization allows the compiler to drop unused
functions, which is very popular with users (a lot use it to get smaller
kernel images)

-Andi

-- 
ak at linux.intel.com -- Speaking for myself only.
