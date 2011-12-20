From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 20 Dec 2011 13:19:34 +0000
Subject: [PATCH v6 04/11] ARM: davinci: dm646x: remove the macros from
 the	header to move to c file
In-Reply-To: <1323951120-15876-5-git-send-email-manjunath.hadli@ti.com>
References: <1323951120-15876-1-git-send-email-manjunath.hadli@ti.com>
 <1323951120-15876-5-git-send-email-manjunath.hadli@ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B60507C7@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 17:41:53, Hadli, Manjunath wrote:
> move the register base addresses and offsets used only by dm646x
> platform file from platform header dm646x.h to dm646x.c as they
> are used only in the c file.

Comitting this as well with the changes as described for patch
2/11.

Thanks,
Sekhar
