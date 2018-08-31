From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 30 Aug 2018 20:52:52 -0600
Subject: [PATCH v4 00/13] ata: ahci_platform: support allwinner R40 AHCI
In-Reply-To: <CAGb2v67miUjqeKeDh_E_XPee_0Hq1C6YrfXxsOp_=NtQY+LLmQ@mail.gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <f5838eae-fa6c-8699-14a4-95d0daa8a960@kernel.dk>
 <CAGb2v67miUjqeKeDh_E_XPee_0Hq1C6YrfXxsOp_=NtQY+LLmQ@mail.gmail.com>
Message-ID: <8fa866c5-6800-505f-53bc-5c1b27582ca6@kernel.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/30/18 8:32 PM, Chen-Yu Tsai wrote:
> Hi,
> 
> On Fri, Aug 31, 2018 at 4:31 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/30/18 1:01 PM, Corentin Labbe wrote:
>>> Hello
>>>
>>> This patchset add support for allwinner R40 AHCI controller.
>>>
>>> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
>>> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
>>> by this serie, so no regression should come with it.
>>>
>>> The last patch(ata: ahci_sunxi: remove PHY code) should not be merged,
>>> but will be resent for inclustion when all patchs will have hit linus
>>> tree.
>>
>> Applied 1-12 with Hans's blessing, thanks Corentin.
> 
> Please don't merge device tree ("dts") patches, i.e. patches 9-12. We will
> merge them through the sunxi / armsoc tree. Having them in separate trees
> introduces conflicts when we have other stuff going through our tree.

OK, fair enough, I can drop those.

-- 
Jens Axboe
