From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 29 Mar 2013 19:31:21 +0100
Subject: [PATCH 1/1] video: fbomn: fix type VESA_DMT_VSYNC_HIGH
In-Reply-To: <002801ce2c1c$e93564a0$bba02de0$%han@samsung.com>
References: <1364504606-2087-1-git-send-email-plagnioj@jcrosoft.com>
 <002801ce2c1c$e93564a0$bba02de0$%han@samsung.com>
Message-ID: <20130329183121.GG20693@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:29 Fri 29 Mar     , Jingoo Han wrote:
> On Friday, March 29, 2013 6:03 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > 
> > it's VESA_DMT_VSYNC_HIGH not VESA_DMT_HSYNC_HIGH
> > to check to enable the FB_SYNC_VERT_HIGH_ACT
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: linux-fbdev at vger.kernel.org
> 
> CC'ed Steffen Trumtrar.
> 
> The same patch was already submitted as below:
> (https://patchwork.kernel.org/patch/2183811/)
> 
> I will resend this patch, soon.
did not see ok

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

so

Best Regards,
J.
