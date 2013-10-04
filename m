From: joelf@ti.com (Joel Fernandes)
Date: Thu, 3 Oct 2013 21:00:27 -0500
Subject: [PATCH v2 0/9] ARM: dts: DT data for OMAP platforms for v3.13
In-Reply-To: <524D7038.9070303@baylibre.com>
References: <1380553986-15910-1-git-send-email-joelf@ti.com>
 <524D7038.9070303@baylibre.com>
Message-ID: <524E213B.6030306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/2013 08:25 AM, Benoit Cousson wrote:
> + DT list and DT maintainers.
> 
> Hi Joel,
> 
> Thanks for the update. It looks good to me.
> 
> For the new bindings added below;
> 
>>   .../devicetree/bindings/crypto/omap-aes.txt        | 34 ++++++++++
>>   .../devicetree/bindings/crypto/omap-sham.txt       | 31 +++++++++
> 
> I will need the acked-by from one of the DT maintainers.

Sure. To help with giving Ack for this, I'd like to also mention these patches
were due for long time and reposted. The supporting code is already in the kernel.

Also bindings were reviewed by Mark Rutland comments in the following thread
were addressed:
http://www.spinics.net/lists/arm-kernel/msg269006.html

Mark, could you give Ack for these patches if they look OK?

thanks,

-Joel
