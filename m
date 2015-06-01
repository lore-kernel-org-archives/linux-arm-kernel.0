From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 1 Jun 2015 09:21:44 +0300
Subject: [PATCHv3 00/10] ARM: DRA7: add display support
In-Reply-To: <alpine.DEB.2.02.1506010538330.14902@utopia.booyaka.com>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.02.1506010538330.14902@utopia.booyaka.com>
Message-ID: <556BF9F8.5070500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/06/15 08:46, Paul Walmsley wrote:
> Hi Tomi
> 
> On Wed, 6 May 2015, Tomi Valkeinen wrote:
> 
>> This series adds the arch/arm/ side of the display support for DRA7 (DRA72x,
>> DRA74x, AM54xx) SoCs. Also support for HDMI output on x15 and DRA72 EVM boards
>> is added.
>>
>> This series is v3, and is based on v4.1-rc2. There are no differences to v2,
>> except rebased and tested.
> 
> Are you still planning to move the DESHDCP clock enable to the beginning 
> of the series to avoid the warnings, per:
> 
> http://www.spinics.net/lists/arm-kernel/msg410968.html

Sorry, I totally forgot that. I will do that and send a v4.

> Also, not sure if you can arrange for someone at TI to send over a DRA7xx 
> board for the testbed, but it would be nice to have a board to test these 
> patches with, to avoid issues like the one mentioned in your E-mails...

I'll forward the request.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150601/47ec6423/attachment-0001.sig>
