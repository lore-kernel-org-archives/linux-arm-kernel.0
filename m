From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 20 Dec 2011 09:02:35 +0000
Subject: [PATCH v6 03/11] ARM: davinci: dm365: remove the macros from
 the	header to move to c file
In-Reply-To: <1323951120-15876-4-git-send-email-manjunath.hadli@ti.com>
References: <1323951120-15876-1-git-send-email-manjunath.hadli@ti.com>
 <1323951120-15876-4-git-send-email-manjunath.hadli@ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B60502E2@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 17:41:52, Hadli, Manjunath wrote:
> move the register base addresses and offsets used only by dm365
> platform file from platform header dm365.h to dm365.c as they
> are used only in the c file.
> 
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>

Comitting this patch while making changes to the headline and 
description similar to that I made for patch 2/11

Thanks,
Sekhar
