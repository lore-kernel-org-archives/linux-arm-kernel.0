From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Nov 2016 12:47:17 -0600
Subject: [PATCH 13/13] Documentation: synopsys-dw-mshc: remove the unused
 properties
In-Reply-To: <20161103062135.10697-14-jh80.chung@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
 <20161103062135.10697-14-jh80.chung@samsung.com>
Message-ID: <20161110184717.vgkp2flyi26dmbfo@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 03:21:35PM +0900, Jaehoon Chung wrote:
> "support-highspeed" was the obsoleted property.
> And "broken-cd" is not synopsys specific property.
> It can be referred to mmc.txt binding Documentation.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 5 -----
>  1 file changed, 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
