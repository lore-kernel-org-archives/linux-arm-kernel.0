From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 16 Jan 2013 19:25:20 +0530
Subject: [PATCH v5 1/9] ARM: davinci: da850 board: change pr_warning()
 to pr_warn()
In-Reply-To: <1357863807-380-2-git-send-email-rtivy@ti.com>
References: <1357863807-380-1-git-send-email-rtivy@ti.com>
 <1357863807-380-2-git-send-email-rtivy@ti.com>
Message-ID: <50F6B148.4040300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/11/2013 5:53 AM, Robert Tivy wrote:
> Changed all pr_warning() calls to pr_warn(), as advised by checkpatch.pl.
> 
> Also, while modifying those pr_warning() calls I changed hardcoded
> function names to use '"%s:", __func__' instead, and converted acronym
> usage to upper case
> 
> Signed-off-by: Robert Tivy <rtivy@ti.com>

Applying this patch for v3.9. While committing I updated the commit
message to change past tense to present and also removed the first
person reference.

Thanks,
Sekhar
