From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 29 Jan 2010 09:02:13 +0000
Subject: [PATCH] ARM: SAMSUNG: Move map-base to plat-samsung
In-Reply-To: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
References: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264755741-16184-3-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the map-base file to plat-samsung. To make the move easier, we do not
change the S3C_ prefix on many of the items as this would involve going
through altering all the dependencies.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 .../include/plat/map-base.h                        |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/map-base.h (100%)

diff --git a/arch/arm/plat-s3c/include/plat/map-base.h b/arch/arm/plat-samsung/include/plat/map-base.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/map-base.h
rename to arch/arm/plat-samsung/include/plat/map-base.h
-- 
1.6.0.4
