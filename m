From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 10 Aug 2016 13:15:39 +0300
Subject: [PATCH 0/6] CLCD support for Nomadik and Versatile series
In-Reply-To: <CACRpkdY6FDisofanQX9oiXMr2otoBsYKsx+fTs-EkV2F-004Eg@mail.gmail.com>
References: <1466069778-16087-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdY6FDisofanQX9oiXMr2otoBsYKsx+fTs-EkV2F-004Eg@mail.gmail.com>
Message-ID: <e706d8a8-8321-562f-7084-b60d637f53c3@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/07/16 15:41, Linus Walleij wrote:
> Hi Tomi,
> 
> On Thu, Jun 16, 2016 at 11:36 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
> 
>> This is a rebase and repost of my earlier "uncontroversial"
>> series of patches to CLCD, which excludes the part where
>> we deal with the Versatile autodetected displays. This makes
>> it possible to handle Nomadik graphics and RealView with just
>> device tree while keeping the Versatile specialties on hold.
>>
>> We got an earlier nod from Tomi on this series:
>> http://marc.info/?l=linux-fbdev&m=145733624305361&w=2
> 
> Is there any chance that we can progress with this series
> for the v4.8 kernel?

Sorry, I was out the whole July. I've queued this for v4.9, should be in
linux-next in a few days.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160810/66e4ecc4/attachment.sig>
