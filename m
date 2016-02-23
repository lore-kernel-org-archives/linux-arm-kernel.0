From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 23 Feb 2016 10:32:04 -0800
Subject: [PATCH] ARM64: dts: Mediatek: mt8173-evb: fix access MMC fail
 issue
In-Reply-To: <56CC1E0E.4050400@gmail.com> (Matthias Brugger's message of "Tue,
 23 Feb 2016 09:53:34 +0100")
References: <1455861643-24307-1-git-send-email-eddie.huang@mediatek.com>
 <7h37skw9jd.fsf@baylibre.com> <56CC1E0E.4050400@gmail.com>
Message-ID: <7hlh6bth0b.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matthias Brugger <matthias.bgg@gmail.com> writes:

> On 23/02/16 01:32, Kevin Hilman wrote:
>> Eddie Huang <eddie.huang@mediatek.com> writes:
>>
>>> MT8173 E1 chip has one bug that if turn off USB power domain, vcore
>>> power will also be off, thus cause modules using vcore power domain
>>> fail, like MMC. The E1 chip only found on MT8173-evb board and this
>>> board only has E1 chip, so implement this as a board specific
>>> workaround.
>>>
>>> Pwrapper use vcore power, so add pwrapper using USB power domain to
>>> keep USB power domain not to zero and disabled.
>>>
>>> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
>>
>> Tested-by: Kevin Hilman <khilman@baylibre.com>
>>
>
> I send the patch in a pull request yesterday, so I won't be able to
> add your tag.

No worries.  Was on vacation, so couldn't test sooner.

> Thanks for testing and reporting this issue!

You're welcome,

Kevin
