From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Jan 2013 20:39:37 +0530
Subject: [RFC v2 09/18] ARM: OMAP2+: AM33XX: hwmod: Update the WKUP-M3
 hwmod with reset status bit
In-Reply-To: <1356959231-17335-10-git-send-email-vaibhav.bedia@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-10-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <50EC36B1.3030704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav,

On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> WKUP-M3 has a reset status bit (RM_WKUP_STST.WKUP_M3_LRST)
> Update the WKUP-M3 hwmod data to reflect the same.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
I think you should make a separate series for
the data file updates/fixes.

Regards
Santosh
