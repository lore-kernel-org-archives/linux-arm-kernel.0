From: willy@infradead.org (Matthew Wilcox)
Date: Tue, 10 Apr 2018 09:09:32 -0700
Subject: [PATCH v2 1/2] mm: introduce ARCH_HAS_PTE_SPECIAL
In-Reply-To: <1523373951-10981-2-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1523373951-10981-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523373951-10981-2-git-send-email-ldufour@linux.vnet.ibm.com>
Message-ID: <20180410160932.GB3614@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2018 at 05:25:50PM +0200, Laurent Dufour wrote:
>  arch/powerpc/include/asm/pte-common.h                  | 3 ---
>  arch/riscv/Kconfig                                     | 1 +
>  arch/s390/Kconfig                                      | 1 +

You forgot to delete __HAVE_ARCH_PTE_SPECIAL from
arch/riscv/include/asm/pgtable-bits.h
