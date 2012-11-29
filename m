From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 29 Nov 2012 10:42:18 +0200
Subject: [PATCH] video: da8xx-fb: clk_get on connection id fck
In-Reply-To: <A73F36158E33644199EB82C5EC81C7BC3E9FB8D9@DBDE01.ent.ti.com>
References: <1353415261-30080-1-git-send-email-prakash.pm@ti.com>
 <50AB7F7E.1070400@ti.com>
 <A73F36158E33644199EB82C5EC81C7BC3E9FB8D9@DBDE01.ent.ti.com>
Message-ID: <50B71FEA.1070503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-23 06:33, Manjunathappa, Prakash wrote:
> Hi Tomi,
> 
> On Tue, Nov 20, 2012 at 18:32:54, Nori, Sekhar wrote:
>> On 11/20/2012 6:11 PM, Manjunathappa wrote:
>>> do clk_get on connection id "fck" to support OMAP based
>>> platforms having multiple clocks for module. Without this
>>> driver change clk_get fails on am335x.
>>>
>>> This patch is based on the discussion in community
>>> http://marc.info/?l=linux-kernel&m=135166018907827&w=2
>>>
>>> Signed-off-by: Manjunathappa <prakash.pm@ti.com>
>>> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
>>
>> For the mach-davinci changes:
>>
>> Acked-by: Sekhar Nori <nsekhar@ti.com>
>>
>> Florian,
>>
>> I assume you will want to take this through your tree?
>>
> 
> Could you please pull in this?

Merged this and the "da8xx-fb: LCDC driver cleanup" to:

git://gitorious.org/linux-omap-dss2/linux.git for-next

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121129/affe6c0b/attachment.sig>
