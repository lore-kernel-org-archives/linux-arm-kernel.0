From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 4 Jan 2013 14:31:24 +0530
Subject: [PATCH v4 1/9] ARM: davinci: da850 board: change pr_warning()
 to pr_warn()
In-Reply-To: <1355967254-16726-2-git-send-email-rtivy@ti.com>
References: <1355967254-16726-1-git-send-email-rtivy@ti.com>
 <1355967254-16726-2-git-send-email-rtivy@ti.com>
Message-ID: <50E69A64.4060306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2012 7:04 AM, Robert Tivy wrote:
> Also, while modifying those pr_warning() calls I changed hardcoded
> function names to use '"%s:", __func__' instead, and converted acronym
> usage to upper case
> 
> Signed-off-by: Robert Tivy <rtivy@ti.com>
> ---
> Clean up files that will be otherwise modified in subsequent patch.
> 
> Applies to v3.7-rc2 tag (commit 6f0c0580b70c89094b3422ba81118c7b959c7556) of
> Linus' mainline kernel at git.kernel.org.

This doesnt apply to the latest (v3.8-rc2) kernel anymore. Can you
please rebase and resend?

Nit: Patch description should be complete even when read without the
subject line. Please fix this as well when reposting.

Looks fine otherwise.

Thanks,
Sekhar
