From: ben-linux@fluff.org (Ben Dooks)
Date: Fri,  8 Jan 2010 02:30:10 +0000
Subject: [S3C-CLK] ARM: SAMSUNG: Move <plat/clock.h> to plat-samsung
In-Reply-To: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
References: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1262917822-26004-3-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the <plat/clock.h> header to plat-samsung where it can be used by all
the platforms, and readies it for the next round of clock updates where
the clock code will be amalgamated.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 .../include/plat/clock.h                           |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/clock.h (100%)

diff --git a/arch/arm/plat-s3c/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/clock.h
rename to arch/arm/plat-samsung/include/plat/clock.h
-- 
1.6.0.4
