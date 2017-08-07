From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Mon, 7 Aug 2017 06:23:23 -0700
Subject: [PATCH v4 2/2] ARM: dts: keystone-k2g: Add gpio nodes
In-Reply-To: <1501825654-19266-2-git-send-email-j-keerthy@ti.com>
References: <1501825654-19266-1-git-send-email-j-keerthy@ti.com>
 <1501825654-19266-2-git-send-email-j-keerthy@ti.com>
Message-ID: <bccc7075-43eb-6131-7bbd-4f266d1fb509@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/3/17 10:47 PM, Keerthy wrote:
> 66AK2G has 2 instances of gpio. The first one has all the 144 GPIOs
> functional. 9 banks with 16 gpios making a total of 144. The second
> instance has only the GPIO0:GPIO67 functional and rest are marked
> reserved.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> 
Applied 2/2. I see Linus W has picked up 1/2.

Regards,
Santosh
