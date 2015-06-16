From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 16 Jun 2015 16:27:28 -0700
Subject: [PATCH 12/12] msm: msm_fb: Remove dead code
In-Reply-To: <55806E63.8020509@codeaurora.org> (Stephen Boyd's message of
 "Tue, 16 Jun 2015 11:43:47 -0700")
References: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
 <1426270185-19510-13-git-send-email-sboyd@codeaurora.org>
 <20150313185109.GE14457@ns203013.ovh.net>
 <55806E63.8020509@codeaurora.org>
Message-ID: <7h7fr3w7xb.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

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

It's all drivers/video/fbdev/*, so it's not arm-soc material. Looks to
me like it should go through the fbdev tree.

Kevin
