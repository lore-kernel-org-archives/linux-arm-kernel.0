From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 16 Feb 2015 10:30:52 +0200
Subject: [PATCH 0/9] ARM: DRA7: add display support
In-Reply-To: <54DE1FD9.6030801@ti.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
 <54DE1FD9.6030801@ti.com>
Message-ID: <54E1AABC.5010907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/02/15 18:01, Nishanth Menon wrote:
> On 02/13/2015 09:11 AM, Tomi Valkeinen wrote:
>> Hi,
>>
>> This series adds the arch/arm/ side of the display support for DRA7 (DRA72x,
>> DRA74x, AM54xx) SoCs. Also support for HDMI output on x15 and DRA72 EVM boards
>> is added.
>>
>> The series is based on OMAPDSS driver patches in fbdev changes for 3.20, which
>> have been merged to Linus' tree.
>>
>> The changes are very similar to OMAP5 DSS. All the other patches look fine to
>> me except the "RFC: ARM: DRA7: enable DSS_DESHDCP_CLKEN". That's been discussed
>> earlier with Paul and Tero, but I don't think we have any good solution for it
>> yet.
> 
> Is there some specific tag I can test this on (some next perhaps?), I

Linus's master or linux-next should work. This series is based on the
fbdev changes for 3.20. So if Linus' master or linux-next doesn't work,
v3.19 + fbdev-3.20 + this series should work.

> Further are you proposing this for 3.20 or 3.21 window? 3.20, we seem
> to have already missed.

3.21.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150216/ac3e3b68/attachment.sig>
