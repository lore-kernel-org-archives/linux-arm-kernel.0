From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Tue, 24 Jul 2018 23:00:16 +0900
Subject: [PATCH/RFT 0/7] rsnd: add support for r8a77965
In-Reply-To: <20180723162153.vh3cmx2pijlifthl@verge.net.au>
References: <1531856883-19645-1-git-send-email-ykaneko0929@gmail.com>
 <20180723162153.vh3cmx2pijlifthl@verge.net.au>
Message-ID: <CAH1o70JuXT7bdFLp1tBsrCbKj2HG7UZ4v7LMO4OgRHGnWQAHFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon-san,

2018-07-24 1:21 GMT+09:00 Simon Horman <horms@verge.net.au>:
> On Wed, Jul 18, 2018 at 04:47:56AM +0900, Yoshihiro Kaneko wrote:
>> This series adds sound support for r8a77965 (R-Car M3-N).
>> This series is based on the devel branch of Simon Horman's renesas tree.
>>
>> Hiroyuki Yokoyama (1):
>>   ASoC: rsnd: Document R-Car M3-N support
>>
>> Takeshi Kihara (6):
>>   arm64: dts: renesas: r8a77965: Add Audio-DMAC device nodes
>>   arm64: dts: renesas: r8a77965: Add Sound device node and SSI support
>>   arm64: dts: renesas: r8a77965: Add Sound SRC support
>>   arm64: dts: renesas: r8a77965: Add Sound DVC device nodes
>>   arm64: dts: renesas: r8a77965: Add Sound CTU support
>>   arm64: dts: renesas: r8a77965: Add Sound MIX support
>>
>>  .../devicetree/bindings/sound/renesas,rsnd.txt     |   1 +
>>  arch/arm64/boot/dts/renesas/r8a77965.dtsi          | 245 ++++++++++++++++++++-
>
> Thanks Kaneko-san,
>
> in general this series looks good, however, I would like to ask you to
> squash all the dts patches (the patches by Kihara-san) into a single patch.
>
> For many years now we have split patches up as this series does.
> And no doubt that is why BPS team chose to split up the patches
> that you have based this patchset on. However, we were recently
> asked by the Olof Johansson to squash patches together to make
> the high-level intent of patches clearer to him in his position
> of ARM-SoC co-maintainer.
>
> So while what you have done is correct, it is now the "old way".
> Please squash the patches together as this is the "new way".

Thank you for the detailed explanation.
I will do it.

>
> Thanks!

Best regards,
Kaneko
