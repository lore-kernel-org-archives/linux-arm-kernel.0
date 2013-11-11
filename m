From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 11 Nov 2013 15:34:02 +0200
Subject: [PATCH 11/12] fbdev: shmobile-hdmi: Convert to
 clk_prepare/unprepare
In-Reply-To: <1388008.xjh7MrPrF3@avalon>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131031104809.GB18477@ns203013.ovh.net> <1388008.xjh7MrPrF3@avalon>
Message-ID: <5280DCCA.7060106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-11-09 16:13, Laurent Pinchart wrote:
> Hi Jean-Christophe,
> 
> On Thursday 31 October 2013 11:48:09 Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 23:49 Mon 28 Oct     , Laurent Pinchart wrote:
>>> Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
>>> clk_disable_unprepare() to get ready for the migration to the common
>>> clock framework.
>>>
>>> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>
>> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> Thank you. Could you please pick patches 11/12 and 12/12 up for v3.13 or v3.14 
> ?

Thanks, picked both for 3.13.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131111/4b2bc4fc/attachment.sig>
