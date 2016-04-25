From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 25 Apr 2016 16:18:02 +0000 (UTC)
Subject: [PATCH v6 0/7] ARM: dts: DRA7: Add dt nodes for PWMSS
In-Reply-To: <1461343238-29274-1-git-send-email-fcooper@ti.com>
References: <1461343238-29274-1-git-send-email-fcooper@ti.com>
Message-ID: <alpine.DEB.2.02.1604251610170.22464@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Apr 2016, Franklin S Cooper Jr wrote:

> This patch series adds support for PWM for DRA7. The IP is the same as the
> one present in AM33XX and AM437XX.
> 
> However, before doing so remove unnecessary hwmod entries for eCAP, ePWM
> and eQEP.

Just took a quick look (nothing indepth).  Looks OK.  

Once Rob's issues have been addressed, please feel free to add an 
Acked-by: from me.  Thanks for playing along, Franklin, I think this final 
product makes the most sense from a device architecture point of view.


- Paul
