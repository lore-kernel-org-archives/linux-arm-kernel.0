From: codekipper@gmail.com (Code Kipper)
Date: Wed, 18 Jan 2017 08:09:00 +0100
Subject: [linux-sunxi] Re: [PATCH] ASoC: sunxi: Add bindings for sun8i to
 SPDIF
In-Reply-To: <20170117181531.fdwc5vglpvxpx7su@sirena.org.uk>
References: <20170112173343.9953-1-codekipper@gmail.com>
 <20170117181531.fdwc5vglpvxpx7su@sirena.org.uk>
Message-ID: <CAEKpxBmkbYJzMdn-BFTa0485XSDPcMd6yQHgaqKQZoirG_DnUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 January 2017 at 19:15, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jan 12, 2017 at 06:33:43PM +0100, codekipper at gmail.com wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> The H3 SoC uses the same SPDIF block as found in earlier SoCs, but the
>> transmit fifo is at a different address.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt | 1 +
>>  1 file changed, 1 insertion(+)
>
> This is fine but it doesn't actually add the compatible string to the
> driver which I'd expect.
Hi Mark,
I missed the binding documentation on the patch for the driver so I
pushed it separately instead of pushing a new patch version.
You can find it under the subject heading 'ASoC: sun4i-spdif: Add
support for the H3 SoC' and Maxime has ACK it (on the condition that I
add the binding doc).
BR,
CK
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
