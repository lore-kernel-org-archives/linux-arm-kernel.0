From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 30 Aug 2012 20:56:14 +0000 (UTC)
Subject: [PATCH v4 0/3] Prepare for OMAP2+ movement to Common Clk
In-Reply-To: <1346230576-20004-1-git-send-email-rnayak@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1208302052210.29754@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra

On Wed, 29 Aug 2012, Rajendra Nayak wrote:

> Changes in v4:
> * Added *hack* comments around clk_prepare usage in hwmod
> rebased on 3.6-rc

Assuming this is so (haven't looked closely at this series yet), and after 
the existing comments are taken into consideration and a new version 
reposted, will queue this series for 3.7.

Care to respin your series that converts the data also, on top of your new 
version of this series?  We should try to get that into 3.7 also.
BTW are you still waiting for something from Vaibhav Hiremath for this?  
Or can the scripts convert the existing clock33xx_data.c also?


- Paul
