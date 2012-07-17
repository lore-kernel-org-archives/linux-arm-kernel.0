From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2012 14:14:19 +0000
Subject: [RFC PATCH 05/12] ARM: Add DT support to decompressor tags
In-Reply-To: <20120715024609.513918780@gmail.com>
References: <20120715024408.747946928@gmail.com>
 <20120715024609.513918780@gmail.com>
Message-ID: <201207171414.19624.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 15 July 2012, Domenico Andreoli wrote:
> -ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
>  OBJS   += $(libfdt_objs) atags_to_fdt.o
> -endif

Can you explain why this is necessary? I don't see any code
of that file being called from the newly added code for the
case where CONFIG_ARM_ATAG_DTB_COMPAT is disabled.

	Arnd
