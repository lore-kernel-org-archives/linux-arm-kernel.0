From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 14 Mar 2016 17:24:21 +0530
Subject: [PATCH 3/4] mmc: davinci: prepare clock
In-Reply-To: <1457567405-30475-4-git-send-email-david@lechnology.com>
References: <1457567405-30475-1-git-send-email-david@lechnology.com>
 <1457567405-30475-4-git-send-email-david@lechnology.com>
Message-ID: <56E6A66D.1080909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 March 2016 05:20 AM, David Lechner wrote:
> When trying to use this driver with the common clock framework, enabling
> the clock fails because it was not prepared. This fixes the problem by
> calling clk_prepare and clk_enable in a single function.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Patch looks good. But I wonder how you hit this issue since we dont use
common clock framework on mach-davinci and this driver is not used
anywhere else AFAIK.

Regards,
Sekhar
