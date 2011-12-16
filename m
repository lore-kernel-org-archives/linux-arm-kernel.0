From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 16 Dec 2011 01:41:32 -0700 (MST)
Subject: [PATCHv8 5/5] OMAP: I2C: Remove the SYSC register definition
In-Reply-To: <1323773758-6375-6-git-send-email-shubhrajyoti@ti.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com>
 <1323773758-6375-6-git-send-email-shubhrajyoti@ti.com>
Message-ID: <alpine.DEB.2.00.1112160140540.12660@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi 

On Tue, 13 Dec 2011, Shubhrajyoti D wrote:

> The SYSC register should not accessed in the driver removing the
> define from the driver.
> Also clean up the syscstate from the omap_i2c_dev struct.
> 
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)

Same for this patch - it either needs to be acked by Ben with a note that 
it's okay for us to merge through the OMAP tree, or needs to be merged by 
Ben during the 3.4 merge window, after patches 1-3 have reached the 
mainline tree.


- Paul
