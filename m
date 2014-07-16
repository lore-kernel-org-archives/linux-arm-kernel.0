From: geoff@infradead.org (Geoff Levand)
Date: Wed, 16 Jul 2014 16:14:10 -0700
Subject: [PATCH v7 03/11] arm64: Do not initialise the fixmap page
 tables in head.S
In-Reply-To: <1405537792-23666-4-git-send-email-catalin.marinas@arm.com>
References: <1405537792-23666-1-git-send-email-catalin.marinas@arm.com>
 <1405537792-23666-4-git-send-email-catalin.marinas@arm.com>
Message-ID: <1405552450.7262.28.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-07-16 at 20:09 +0100, Catalin Marinas wrote:
> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h

> + * image. Both require a pgd and a next level table to (section) map the
> + * kernel. The the swapper also maaps the FDT (see __create_page_tables for
                                  ^^^^^ maps

-Geoff
