From: sameo@linux.intel.com (Samuel Ortiz)
Date: Wed, 21 Nov 2012 14:47:58 +0100
Subject: [PATCH v3 2/5] mfd: tps65217: Set PMIC to shutdown on PWR_EN
 toggle
In-Reply-To: <1353404927-14412-3-git-send-email-anilkumar@ti.com>
References: <1353404927-14412-1-git-send-email-anilkumar@ti.com>
 <1353404927-14412-3-git-send-email-anilkumar@ti.com>
Message-ID: <20121121134758.GS18738@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anilkumar,

On Tue, Nov 20, 2012 at 03:18:44PM +0530, AnilKumar Ch wrote:
> From: Colin Foe-Parker <colin.foeparker@logicpd.com>
> 
> Set tps65217 PMIC status to OFF if power enable toggle is supported.
> By setting this bit to 1 to enter PMIC to OFF state when PWR_EN pin
> is pulled low. Also adds a DT flag to specify that device pmic
> supports shutdown control or not.
> 
> Signed-off-by: Colin Foe-Parker <colin.foeparker@logicpd.com>
> [anilkumar at ti.com: move the additions to tps65217 MFD driver]
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  .../devicetree/bindings/regulator/tps65217.txt     |    4 ++++
>  drivers/mfd/tps65217.c                             |   12 ++++++++++++
>  2 files changed, 16 insertions(+)
Applied, thanks.
I suppose you're not expecting the whole patchset to go through one tree ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
