From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 31 Mar 2013 01:39:09 +0000 (UTC)
Subject: [PATCH 6/8] SERIAL: OMAP: Remove the slave idle handling from
 the driver
In-Reply-To: <1361354444-18230-1-git-send-email-santosh.shilimkar@ti.com>
References: <1361354444-18230-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.DEB.2.00.1303310136490.6436@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Wed, 20 Feb 2013, Santosh Shilimkar wrote:

> UART IP slave idle handling now taken care by runtime pm backend(hwmod layer)
> so remove the hackery from the driver.
> 
> Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Tested-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Rajendra nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

I'm fine with the basic idea.  But based on rmk's and your 
subsequent comments, please add some comments to the driver in this patch 
that encapsulates what needs to be done to get DMA working again properly, 
including the idle mode switching, in the unlikely event that someone will 
try to get that working again.


- Paul
