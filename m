From: olof@lixom.net (Olof Johansson)
Date: Tue, 20 Jan 2015 10:24:50 -0800
Subject: linux-next: manual merge of the omap tree with the arm-soc tree
In-Reply-To: <20150120171048.GF7718@atomide.com>
References: <20150120110947.1a92a416@canb.auug.org.au>
 <20150120171048.GF7718@atomide.com>
Message-ID: <CAOesGMjc+q5ZEFU4GugJT2RCSmhv48DAA8JzuCxf63eEO6tWVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 9:10 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Stephen Rothwell <sfr@canb.auug.org.au> [150119 16:12]:
>> Hi Tony,
>>
>> Today's linux-next merge of the omap tree got a conflict in
>> arch/arm/boot/dts/Makefile between commit cb612390e546 ("ARM: dts: Only
>> build dtb if associated Arch and/or SoC is enabled") from the arm-soc
>> tree and commit ac7452cee743 ("ARM: dts: Add minimal support for
>> dm8168-evm") from the omap tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary (no action
>> is required).
>
> Uhh why is cb612390e546 doing formatting changes all over the place?
> That's a sure way to produce merge conflicts..

It's intentional but a but annoying, yes -- we're resolving them as we
merge in new DT contents so it won't be exposed outside of our tree
(and -next, unfortunately).


-Olof
