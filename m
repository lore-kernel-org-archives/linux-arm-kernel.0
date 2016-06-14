From: hramrach@gmail.com (Michal Suchanek)
Date: Tue, 14 Jun 2016 06:50:27 +0200
Subject: [PATCH v3 00/13] sunxi spi fixes
In-Reply-To: <20160613195716.GD9354@lukather>
References: <cover.1465490774.git.hramrach@gmail.com>
 <20160613195716.GD9354@lukather>
Message-ID: <CAOMqctS7DQ_MtTUd+W4=RYzANSCt5OSRkuwejfkCG2qAXQQhpw@mail.gmail.com>
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
> So, you didn't run that code through checkpatch and you rewrite the
> whole thing entirely without even testing it... Awesome.

Aside from the DMA part this is not a rewrite.

And I did run the code through checkpatch. It still gives some
warnings about BUG_ON and overly long lines, sure. II don't think
those are that serious or that fixing them would improve the code.

Thanks

Michal
