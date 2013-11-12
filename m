From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 12 Nov 2013 11:09:39 -0500
Subject: [PATCH 09/12] mtd: nand: davinci: reuse driver for Keystone arch
In-Reply-To: <4F5844B3A985794BA902E12C070812375F8D46@DNCE04.ent.ti.com>
References: <1384187188-5776-1-git-send-email-ivan.khoronzhuk@ti.com>,
 <1384187188-5776-10-git-send-email-ivan.khoronzhuk@ti.com>
 <4F5844B3A985794BA902E12C070812375F8D46@DNCE04.ent.ti.com>
Message-ID: <528252C3.5060800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 November 2013 12:09 PM, Khoronzhuk, Ivan wrote:
> The Keystone arch has compatible nand device, so reuse it.
> In case with Keystone it depends on TI_DAVINCI_AEMIF because AEMIF
> driver is responsible to set timings.
> 
> See http://www.ti.com/lit/ug/sprugz3a/sprugz3a.pdf
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
