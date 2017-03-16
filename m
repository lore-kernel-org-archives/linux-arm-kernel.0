From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 16 Mar 2017 22:14:46 +0100
Subject: [PATCH 1/3] devicetree: add vendor prefix for Khadas
In-Reply-To: <61778a7a-3d96-8de3-fd4f-f18aa0938a68@suse.de>
References: <20170304215126.7020-1-martin.blumenstingl@googlemail.com>
 <20170304215126.7020-2-martin.blumenstingl@googlemail.com>
 <20170315195737.vckgpw6qad4d4zjm@rob-hp-laptop>
 <61778a7a-3d96-8de3-fd4f-f18aa0938a68@suse.de>
Message-ID: <CAFBinCAp4G4-Ch7Vunn4mEi-6iWi7UfhA3Uryy9FAhFvwBuyPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 7:00 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Am 15.03.2017 um 20:57 schrieb Rob Herring:
>> On Sat, Mar 04, 2017 at 10:51:24PM +0100, Martin Blumenstingl wrote:
>>> Khadas is a new sub-brand of Shenzhen Wesion Technology CO.,LTD. They
>>> are developing Amlogic and Rockchip based "DIY boxes" (single board
>>> computers): http://khadas.com/
>>> They are best know for their latest product: the Khadas VIM (an Amlogic
>>> GXL S905X based SBC).
>>>
>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> ---
>>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>
> Shouldn't the entry reflect what is in the commit message rather than
> just repeat the prefix? I.e., something like "Khadas by Shenzhen Wesion
> Technology Co., Ltd." (which I believe is the official spelling and
> spacing of these abbreviations also for the commit message).
I took the spelling for "Shenzhen Wesion Technology CO.,LTD." from
their website: [0]

> An Acked-by from the CC'ed vendor would also be desirable. :)
I asked Gouwa, one of the people behind the Khadas VIM boards for
clarification some time ago:
"Khadas is a new brand power by Shenzhen Wesion Technology, 'Khadas'
is brand, 'VIM' is product serial name, like 'Apple + iPhone'"
I think I used the vendor-prefixes "pine64" and "radxa" as reference
(see [1]) when I wrote the patch - and none of the existing entries
seems to follow the "brand by parent company" schema.

@Gouwa, Rob: could you please share your opinion on what the official
"vendor" name for the "khadas" prefix should be?


Regards,
Martin


[0] http://szwesion.com/contact/
[1] http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/vendor-prefixes.txt
