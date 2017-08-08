From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 8 Aug 2017 12:05:26 +0800
Subject: [PATCH v2 0/9] mfd: axp20x: Add basic support for AXP813
In-Reply-To: <20170726083242.k35gnk22h35as55n@flea>
References: <20170726082832.16789-1-wens@csie.org>
 <20170726083242.k35gnk22h35as55n@flea>
Message-ID: <CAGb2v67F0d3WZuiAr9Hp6vTenq2TjfRzwz-XhXtFPzNash-KTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 4:32 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Jul 26, 2017 at 04:28:23PM +0800, Chen-Yu Tsai wrote:
>> Hi everyone,
>>
>> This is v2 of my AXP813 support series. The device tree patches are
>> based on my A83T MMC support series. These will go through the sunxi
>> tree. The dt-binding and mfd patches are based on v4.13-rc1. These
>> will go through Lee's mfd tree.
>>
>> Changes since v1:
>>
>>   - Provided relative path for ac100.txt in dt-bindings/mfd/axp20x.txt
>>
>>   - Added Rob's acks to dt-binding patches
>>
>>   - Added Quentin's "mfd: axp20x: use correct platform device id for
>>     many PEK" patch to this series. This patch depends on mfd changes
>>     in this series. It is included so Lee can take them together in
>>     one go.
>>
>>   - Added Lee's mfd-acks to mfd patches
>>
>>   - Added axp818 compatible with axp813 fallback. The two chips are
>>     identical except for the markings. The added compatible matches
>>     what is actually on the board, to avoid confusing readers.
>>
>>   - Fixed up device tree patches to mention which board is changed
>>
>>   - Added device tree patches for the H8 homlet
>
> For the whole serie,
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied the dts patches for 4.14.

ChenYu
