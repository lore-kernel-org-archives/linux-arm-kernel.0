From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 7 Jan 2012 12:21:08 +0100
Subject: [PATCH v2] ARM: at91: fix at91rm9200 soc subtype handling
In-Reply-To: <1325590712-23414-1-git-send-email-nicolas.ferre@atmel.com>
References: <4F02C900.6090907@atmel.com>
 <1325590712-23414-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20120107112108.GE2854@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:38 Tue 03 Jan     , Nicolas Ferre wrote:
> Currently setting it to PQFP changes subtype to BGA as subtypes are
> swapped in at91rm9200_set_type().
> 
> Wrong subtype causes GPIO bank D not to work at all.
> 
> After this fix, subtype is still set as unknown. But board code should
> fill it in with proper value. Another information is thus printed.
> 
> Bug discovery and first implementation made by Veli-Pekka Peltola.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: stable <stable@vger.kernel.org>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
> ---
