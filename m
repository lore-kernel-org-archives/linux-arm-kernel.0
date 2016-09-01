From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 1 Sep 2016 17:57:11 +0300
Subject: [PATCH] ARM: dts: am57xx-beagle-x15: fix HDMI LS_OE GPIO
In-Reply-To: <c69aadbf-90e4-7aaf-2b90-4d5b543c252a@ti.com>
References: <1472737901-26494-1-git-send-email-tomi.valkeinen@ti.com>
 <b8647621-197c-97d5-8291-26c079e5eae8@ti.com>
 <CAOCHtYhF2KfeK3ccEzZcePbU5H1kwi1tKThZN3NRwXgPsW_bSA@mail.gmail.com>
 <c69aadbf-90e4-7aaf-2b90-4d5b543c252a@ti.com>
Message-ID: <cfa4ea2c-444c-a814-cbea-b183f4214c93@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/16 17:14, Nishanth Menon wrote:

>>> I believe we have A2s being shipped as well. we dont want to break A2s
>>> either -> I propose we refactor the dts to introduce revb1 X15.
>>
>> There are at-least 200 A2's that have been shipped to end users.
>>
>> http://uk.rs-online.com/web/p/processor-microcontroller-development-kits/8874764/
>>
> 
> 
> Thanks. Tomi: if you are ok - I already do have a refactoring code from
> older kernel. I will rebase to latest and repost.

Sounds good to me.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160901/a81fda17/attachment.sig>
