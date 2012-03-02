From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 1 Mar 2012 23:32:31 -0700 (MST)
Subject: [PATCH-V2 2/2] arm:omap:am33xx: Add power domain data
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317E515D@DBDE01.ent.ti.com>
References: <1324803628-16790-1-git-send-email-hvaibhav@ti.com>
 <1324803628-16790-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1202291839130.12752@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A8317E515D@DBDE01.ent.ti.com>
Message-ID: <alpine.DEB.2.00.1203012330490.22980@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 1 Mar 2012, Hiremath, Vaibhav wrote:

> The initialization used in the patch is correct. Unfortunately, the TRM 
> is incorrect here. I have already raised this issue with respective 
> folks and soon it will get corrected.

thanks for looking into this.  Could you add a brief comment or comments 
in this file to indicate that the TRM Rev C is incorrect about those?  
That will help others who may be reviewing this code as they track down 
bugs.


thanks


- Paul
