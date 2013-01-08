From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Jan 2013 20:42:44 +0530
Subject: [RFC v2 11/18] ARM: DTS: AM33XX: Add nodes for OCMC RAM and
 WKUP-M3
In-Reply-To: <1356959231-17335-12-git-send-email-vaibhav.bedia@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-12-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <50EC376C.2020809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> Since AM33XX supports only DT-boot, this is needed
> for the appropriate device nodes to be created.
>
> Note: OCMC RAM is part of the PER power domain and supports
> retention. The assembly code for low power entry/exit will
> run from OCMC RAM. To ensure that the OMAP PM code does not
> attempt to disable the clock to OCMC RAM as part of the
> suspend process add the no_idle_on_suspend flag.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
Looks fine to me.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
