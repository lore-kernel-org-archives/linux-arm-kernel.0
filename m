From: mkelly@xevo.com (Martin Kelly)
Date: Thu, 29 Mar 2018 10:28:43 -0700
Subject: [linux-sunxi] [PATCH v9 0/2] Initial Allwinner V3s CSI Support
In-Reply-To: <20180329090256.e9621262cf069c475a706087@magewell.com>
References: <1520301070-48769-1-git-send-email-yong.deng@magewell.com>
 <9b60dee0-2504-6ae3-fda3-64c4458025c3@xevo.com>
 <20180329090256.e9621262cf069c475a706087@magewell.com>
Message-ID: <a6205796-ee42-1ecc-dfaa-74c196bcadd1@xevo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2018 06:02 PM, Yong wrote:
> 
> AFAIK, there is no document about MIPI CSI-2. You can take a look at the
> source code in BSP:
> https://github.com/friendlyarm/h3_lichee/tree/master/linux-3.4/drivers/media/video/sunxi-vfe/mipi_csi
> And try to port it to mainline.
> 

Yep, I see there's lots of magic constants in that code. I might try to 
forward-port it, but it won't be very maintainable or easy to change 
without a datasheet. That's too bad.

Thanks for the information, Yong.
