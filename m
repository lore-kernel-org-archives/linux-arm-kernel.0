From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 01 Aug 2012 16:08:38 +0400
Subject: [PATCH 06/22] ARM: LPAE: use phys_addr_t in alloc_init_pud()
In-Reply-To: <1343775898-28345-7-git-send-email-cyril@ti.com>
References: <1343775898-28345-1-git-send-email-cyril@ti.com>
 <1343775898-28345-7-git-send-email-cyril@ti.com>
Message-ID: <50191C46.4090902@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-08-2012 3:04, Cyril Chemparathy wrote:

> From: Vitaly Andrianov <vitalya@ti.com>

> This patch fixes the alloc_init_pud() function to use phys_addr_t instead of
> unsigned long when passing in the phys argument.

> This is an extension to commit 97092e0c56830457af0639f6bd904537a150ea4a, which

    Please also specify that commit's summary in parens.

> applied similar changes elsewhere in the ARM memory management code.

> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>

WBR, Sergei
