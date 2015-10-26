From: pku.leo@gmail.com (Leo Li)
Date: Mon, 26 Oct 2015 17:20:27 -0500
Subject: [PATCH V6 5/6] clk: qoriq: Add ls1043a support.
In-Reply-To: <1445587282-29529-5-git-send-email-B48286@freescale.com>
References: <1445587282-29529-1-git-send-email-B48286@freescale.com>
 <1445587282-29529-5-git-send-email-B48286@freescale.com>
Message-ID: <CADRPPNSS62G3D8ghNjd1kJMSjXkQJ9bfqeTP_ZqMk2ehRN5iyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 3:01 AM, Zhiqiang Hou <B48286@freescale.com> wrote:
> From: Hou Zhiqiang <B48286@freescale.com>
>
> Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> V6: V5 V4 V3 V2
>  - No change.

I know you mentioned the dependency in the summary of the patch
series.  But it's not likely these dependencies will be merged through
the ARM sub-maintainers tree and be resolved in this merge window.  So
it will be better to mention these dependencies here so that this
patch will go through the same tree as these dependency patches.

Scott,

What is your plan to merge the clock patches?  This patch need to go
together with it.

Regards,
Leo
