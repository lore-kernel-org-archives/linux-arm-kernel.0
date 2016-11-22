From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 22 Nov 2016 16:12:08 +0530
Subject: [RESEND PATCH 3/3] ARM: davinci: remove ohci platform usage
In-Reply-To: <20161121165349.29128-4-ahaslam@baylibre.com>
References: <20161121165349.29128-1-ahaslam@baylibre.com>
 <20161121165349.29128-4-ahaslam@baylibre.com>
Message-ID: <995f3c7a-bb06-dbb4-81b5-5ad08859cc27@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 November 2016 10:23 PM, Axel Haslam wrote:
> As all users of ohci platform data have been converted
> to use a regulator, we dont need to pass platform
> data to register the ohci device anymore.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

This looks good to me.

Thanks,
Sekhar
