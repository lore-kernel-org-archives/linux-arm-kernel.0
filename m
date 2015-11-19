From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 19 Nov 2015 21:31:13 +0100
Subject: [PATCH v2 PART-RESEND 0/2] berlin sdhci clock clean up
In-Reply-To: <1447671395-8023-1-git-send-email-jszhang@marvell.com>
References: <1447671395-8023-1-git-send-email-jszhang@marvell.com>
Message-ID: <564E3191.8060109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.11.2015 11:56, Jisheng Zhang wrote:
> Add or fix the optional clock property, then remove the CLK_IGNORE_UNUSED
> flag for sdio clk(s).
> 
> This is a partialy resend of 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/379457.html
> 
> patch3, patch4 has been merged.

Great! Really!

As they have been taken without my Acked-by, ignoring my request to
_not_ remove the CLK_IGNORE_UNUSED flags _before_ these two, the
remaining patches now become fixes.

Please resend the patches with a proper description what and why they
are fixes now.

Sebastian
