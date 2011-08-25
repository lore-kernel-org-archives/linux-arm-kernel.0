From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 25 Aug 2011 17:55:08 +0200
Subject: [PATCH v3] at91: merge board usb-a9260 and usb-a9263 together
In-Reply-To: <1314281314-28912-1-git-send-email-nicolas.ferre@atmel.com>
References: <1314281314-28912-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20110825155508.GB2284@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:08 Thu 25 Aug     , Nicolas Ferre wrote:
> From: Nico Erfurth <ne@erfurth.eu>
> 
> Merge boards together as they are barely the same.
> 
> Signed-off-by: Nico Erfurth <ne@erfurth.eu>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> [nicolas.ferre at atmel.com: updated to new machine_desc structure]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Gregory Hermant <gregory.hermant@calao-systems.com>
> ---
> Hi,
> 
> I come back to this patch in the process of collecting things that has been
> left on the mailing-list.
> Gregory, can you have a loot at it?
> 
> v3: update the machine_desc structure to match latest improvements.
> v2: update against new common init
>     we must use it as we can detect the cpu type only after mapping
>     the system controler.
I've the hardware now

I'll re test it myself

I'm adding the usb-a9g20 right now too in the same fime

Best Regards,
J.
