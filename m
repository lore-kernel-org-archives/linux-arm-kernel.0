From: codekipper@gmail.com (Code Kipper)
Date: Tue, 3 Jul 2018 19:19:16 +0200
Subject: [linux-sunxi] ARM: dts: sun8i: h3: Enable dwmac-sun8i on the
 Beelink X2
In-Reply-To: <20180703145020.hkct43ccbpteleht@flea>
References: <20180630062720.24225-1-codekipper@gmail.com>
 <20180703145020.hkct43ccbpteleht@flea>
Message-ID: <CAEKpxBmCLF8PMQ2h2qghfMEMktQYdDZEPaFRLvN8-uzDr0mi9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 July 2018 at 16:50, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> Hi,
>
> On Sat, Jun 30, 2018 at 08:27:20AM +0200, codekipper at gmail.com wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> The enabling of the emac was reverted when stability issues were
>> discovered.
>
> What stability issues exactly? Have they been fixed? If so, by which
> commit?

They were fixed by 4904337fe34f (ARM: dts: sunxi: Restore EMAC changes
(boards)) but this board was missed.
CK
>
> Maxime
>
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
