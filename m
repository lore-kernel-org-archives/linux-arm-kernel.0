From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 16 Mar 2017 07:00:55 +0100
Subject: [PATCH 1/3] devicetree: add vendor prefix for Khadas
In-Reply-To: <20170315195737.vckgpw6qad4d4zjm@rob-hp-laptop>
References: <20170304215126.7020-1-martin.blumenstingl@googlemail.com>
 <20170304215126.7020-2-martin.blumenstingl@googlemail.com>
 <20170315195737.vckgpw6qad4d4zjm@rob-hp-laptop>
Message-ID: <61778a7a-3d96-8de3-fd4f-f18aa0938a68@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 15.03.2017 um 20:57 schrieb Rob Herring:
> On Sat, Mar 04, 2017 at 10:51:24PM +0100, Martin Blumenstingl wrote:
>> Khadas is a new sub-brand of Shenzhen Wesion Technology CO.,LTD. They
>> are developing Amlogic and Rockchip based "DIY boxes" (single board
>> computers): http://khadas.com/
>> They are best know for their latest product: the Khadas VIM (an Amlogic
>> GXL S905X based SBC).
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>  1 file changed, 1 insertion(+)
> 
> Acked-by: Rob Herring <robh@kernel.org>

Shouldn't the entry reflect what is in the commit message rather than
just repeat the prefix? I.e., something like "Khadas by Shenzhen Wesion
Technology Co., Ltd." (which I believe is the official spelling and
spacing of these abbreviations also for the commit message).

An Acked-by from the CC'ed vendor would also be desirable. :)

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
