From: hramrach@gmail.com (Michal Suchanek)
Date: Fri, 17 Jun 2016 12:34:44 +0200
Subject: [PATCH v3 00/13] sunxi spi fixes
In-Reply-To: <20160613195716.GD9354@lukather>
References: <cover.1465490774.git.hramrach@gmail.com>
 <20160613195716.GD9354@lukather>
Message-ID: <CAOMqctS6ZQ3_a97sE2e7H34ZCny2aDE38V1tQA=-SBZwF2sbDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 13 June 2016 at 21:57, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, Jun 13, 2016 at 05:46:48PM -0000, Michal Suchanek wrote:
>> Hello,
>>
>> This is update of the sunxi spi patches that should give full-featured SPI
>> driver.
>>
>> First three patches fix issues with the current driver and can be of use for
>> stable kernels so adding cc for those.
>>
>> I merged the sun4i and sun6i driver because there several issues that need to
>> be fixed in both separately and they are even out of sync wrt some fixes.
>> I guess some of the merge patches can be squashed.
>>
>> I tested this with A10s Olinuxino Micro. I have no sun6i device so I cannot
>> tell if that side was broken by this patchset - especially the last patch that
>> adds DMA was afaik never tested on sun6i.
>

>
> For the record, I'm still very much opposed to such a merge.
>

What is the reason against the merge? I did not find the original discussion.

I tried to rename everything in the drivers from sun4i and sun6i to
sunxi to look at a clean diff and found about 5 differences 2 of which
look like a bug.

Thanks

Michal
