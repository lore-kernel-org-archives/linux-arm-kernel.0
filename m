From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 16 Dec 2011 01:42:13 -0700 (MST)
Subject: [PATCHv8 2/5] OMAP: hwmod/device : add omap_device_reset to
 reset all the hwmods in the device
In-Reply-To: <1323773758-6375-3-git-send-email-shubhrajyoti@ti.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com>
 <1323773758-6375-3-git-send-email-shubhrajyoti@ti.com>
Message-ID: <alpine.DEB.2.00.1112160141510.12660@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, 13 Dec 2011, Shubhrajyoti D wrote:

>     Add a function omap_device_reset() to reset all the hwmods in the hwmod device.
>     This is intended to be used by device drivers to reset all the hwmods in the
>     device. This is needed to support some ips like i2c which  may have to do reset
>     in error paths or in errata.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Thanks, queued for 3.3.

- Paul
