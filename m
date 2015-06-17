From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 17 Jun 2015 12:56:11 +0300
Subject: [PATCH 12/12] msm: msm_fb: Remove dead code
In-Reply-To: <55806E63.8020509@codeaurora.org>
References: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
 <1426270185-19510-13-git-send-email-sboyd@codeaurora.org>
 <20150313185109.GE14457@ns203013.ovh.net> <55806E63.8020509@codeaurora.org>
Message-ID: <5581443B.4080907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/06/15 21:43, Stephen Boyd wrote:
> On 03/13/2015 11:51 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 11:09 Fri 13 Mar     , Stephen Boyd wrote:
>>> This code is no longer used now that mach-msm has been removed.
>>> Delete it.
>>>
>>> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> Cc: David Brown <davidb@codeaurora.org>
>>> Cc: Bryan Huntsman <bryanh@codeaurora.org>
>>> Cc: Daniel Walker <dwalker@fifo99.com>
>>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>
> 
> Thanks again. Should this go through arm-soc (Cced)? Or some other tree
> besides the fb tree? This is the last patch that hasn't been applied in
> this set of 12 patches.

Are all the patches that this depends on already in v4.1-rcX? If so, I
can take this via fbdev.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150617/74bd0ce4/attachment.sig>
