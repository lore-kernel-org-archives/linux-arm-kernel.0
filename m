From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed,  5 Jun 2013 23:18:20 +0200
Subject: [PATCH 15/15] ARM: SAMSUNG: Remove plat/regs-timer.h header
In-Reply-To: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1370467100-10820-16-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since all uses of the header has been removed by previous patches it can
be removed safely.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/plat-samsung/include/plat/regs-timer.h | 124 ------------------------
 1 file changed, 124 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-timer.h

diff --git a/arch/arm/plat-samsung/include/plat/regs-timer.h b/arch/arm/plat-samsung/include/plat/regs-timer.h
deleted file mode 100644
index d097d92..0000000
-- 
1.8.2.1
