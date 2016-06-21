From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Tue, 21 Jun 2016 17:23:18 +0200
Subject: [PATCH] ARM: BCM5301X: Set GPIO enabling USB power on Netgear
 R7000
In-Reply-To: <op.yjevu7en2s3iss@ecaz>
References: <1466509358-25498-1-git-send-email-zajec5@gmail.com>
 <op.yjepy3mr2s3iss@ecaz>
 <CACna6rxm0euw=nVyHZzZa2+Q9U9S4t+aVy34ZvL0Lrx27B8-eA@mail.gmail.com>
 <op.yjevu7en2s3iss@ecaz>
Message-ID: <CACna6ryrABjF3ie8uE6_q-pfNjhQaGbRhNR9jWMEPKwaUt88hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 June 2016 at 16:29, Imre Kaloz <kaloz@openwrt.org> wrote:
> On Tue, 21 Jun 2016 14:26:11 +0200, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
>
>> On 21 June 2016 at 14:22, Imre Kaloz <kaloz@openwrt.org> wrote:
>>>
>>> Is there any reason you are not handling this properly as a regulator
>>> with
>>> usb-nop-xceiv?
>>
>>
>> We can't use USB NOP PHY as we need a specific PHY driver for Broadcom's
>> USB.
>
>
> I see. That shouldn't stop you from addressing the regulator part, tho ;)

How? Be more specific please.

-- 
Rafa?
