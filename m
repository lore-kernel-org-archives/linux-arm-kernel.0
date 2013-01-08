From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Jan 2013 20:35:39 +0530
Subject: [RFC v2 07/18] ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod
 with the right flags
In-Reply-To: <1356959231-17335-8-git-send-email-vaibhav.bedia@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-8-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <50EC35C3.4020701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> TPTC0 needs to be idled and put to standby under SW control.
> Add the appropriate flags in the TPTC0 hwmod entry.
>
Can you please expand TPTC0 in chane log.
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
Patch is fine otherwise.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
