From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Mar 2016 14:43:25 +0530
Subject: [PATCH v2 3/5] mmc: davinci: prepare clock
In-Reply-To: <1457996081-21975-4-git-send-email-david@lechnology.com>
References: <56E6BF7E.7020401@ti.com>
 <1457996081-21975-1-git-send-email-david@lechnology.com>
 <1457996081-21975-4-git-send-email-david@lechnology.com>
Message-ID: <56E7D235.9070404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 March 2016 04:24 AM, David Lechner wrote:
> When trying to use this driver with the common clock framework, enabling
> the clock fails because it was not prepared. This fixes the problem by
> calling clk_prepare and clk_enable in a single function. Ditto for
> clk_disable_unprepare.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Regards,
Sekhar
