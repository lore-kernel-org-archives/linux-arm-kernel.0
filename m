From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Jan 2013 20:52:37 +0530
Subject: [RFC v2 17/18] ARM: OMAP2+: AM33XX: Select Mailbox when PM is
 enabled
In-Reply-To: <1356959231-17335-18-git-send-email-vaibhav.bedia@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-18-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <50EC39BD.2020204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> PM services on AM33XX depend on mailbox for communication
> with WKUP-M3 core so ensure that the right config options
> are selected. Thanks to Kevin Hilman <khilman@deeprootsystems.com>
> for the suggestion on updating the Kconfig and not just
> the omap2plus_defconfig which was done in the previous version
> of the AM33XX suspend-resume support.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Cc: Tony Lingren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
Unrelated to series. You can post this patch separately.

regards
Santosh
