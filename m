From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 1 Mar 2012 18:08:37 -0700 (MST)
Subject: [PATCH] ARM: OMAP: hwmod: Use sysc_fields->srst_shift and get
 rid of hardcoded SYSC_TYPE2_SOFTRESET_MASK
In-Reply-To: <1330609674-20826-1-git-send-email-rnayak@ti.com>
References: <1330609674-20826-1-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1203011808070.22980@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Mar 2012, Rajendra Nayak wrote:

> This is useful when we have broken type2 compliant IPs' where
> the softreset shift is not the same as SYSC_TYPE2_SOFTRESET_SHIFT
> and hence is overridden using sysc_fields->srst_shift.
> 
> We have atleast one such instance now with onchip keypad on OMAP5
> which has a different softreset shift as compared to other type2
> IPs'.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Balaji TK  <balajitk@ti.com>
> Tested-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
> Paul,
> 
> I based the patch on top of your reset/data cleanup series
> for hwmod. So its based on 'hwmod_data_cleanup_3.4' branch.

Thanks, Beno?t's ack added and queued.


- Paul
