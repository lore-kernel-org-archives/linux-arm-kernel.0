From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 10 Feb 2017 13:55:53 +0100
Subject: [PATCH 14/22] ARM: dts: add a devicetree for Raidsonic NAS
 IB-4220-B
In-Reply-To: <alpine.LNX.2.00.1702081353480.8463@T420s>
References: <20170122122254.10764-1-linus.walleij@linaro.org>
 <alpine.LNX.2.00.1702051051090.26313@T420s>
 <CACRpkdb2YUSAD1eR8c11BsCb3yBmMJ7C_bEKkpgkiqX9B4GNwQ@mail.gmail.com>
 <alpine.LNX.2.00.1702081353480.8463@T420s>
Message-ID: <CACRpkdb6vfTsv=rBd_A7igSRQNYayXw=P8LJdY4-gVX5nnoCpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 8, 2017 at 1:55 PM, Hans Ulli Kroll
<ulli.kroll@googlemail.com> wrote:
> On Tue, 7 Feb 2017, Linus Walleij wrote:
>
>> On Sun, Feb 5, 2017 at 10:53 AM, Hans Ulli Kroll
>> <ulli.kroll@googlemail.com> wrote:
>>
>> > Hi Linus,
>> >
>> > please add right baudrate and partition scheme for NAS 4220
>> >
>> > Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
>>
>> Thanks Hans! I folded this into the NAS 4220 device tree
>> and added your Signed-off-by to the patch.
>>
>
> You can remove the PCI entries I've seen on your git tree.
> NAS 4220 has no PCI interface

OK! I just assumed it was on that machine since you were
commenting on the driver, I cut it now.

Yours,
Linus Walleij
