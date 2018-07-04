From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 4 Jul 2018 12:05:43 +0800
Subject: [linux-sunxi] Re: [PATCH v3 15/24] dt-bindings: display:
 sun4i-drm: Add description of A64 HDMI PHY
In-Reply-To: <1814959.07NGAI1aoU@jernej-laptop>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <1669385.k4L9lni8DF@jernej-laptop>
 <CAGb2v67iRZZTQuTH8inwmPC6S0BRecFgPEpKrxgThQbsYaZgmQ@mail.gmail.com>
 <1814959.07NGAI1aoU@jernej-laptop>
Message-ID: <CAGb2v65RUiEFSKe9YO8=bROmtozHKRN4s76QHpY+38PJPLaG7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 30, 2018 at 3:32 AM, Jernej ?krabec <jernej.skrabec@siol.net> wrote:
> Dne ?etrtek, 28. junij 2018 ob 09:00:32 CEST je Chen-Yu Tsai napisal(a):
>> On Thu, Jun 28, 2018 at 12:51 PM, Jernej ?krabec
>>
>> <jernej.skrabec@siol.net> wrote:
>> > Dne ?etrtek, 28. junij 2018 ob 04:19:55 CEST je Chen-Yu Tsai napisal(a):
>> >> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net>
>> >
>> > wrote:
>> >> > A64 HDMI PHY is similar to H3 HDMI PHY except it has two possible PLL
>> >> > clock parents. It is compatible to other HDMI PHYs, like that found in
>> >> > R40.
>> >> >
>> >> > Acked-by: Rob Herring <robh@kernel.org>
>> >> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> >> > ---
>> >> >
>> >> >  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 4 +++-
>> >> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git
>> >> > a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> >> > b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt index
>> >> > 84fe38dbb900..dc83f21ef188 100644
>> >> > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> >> > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> >> > @@ -101,6 +101,7 @@ DWC HDMI PHY
>> >> >
>> >> >  Required properties:
>> >> >    - compatible: value must be one of:
>> >> > +    * allwinner,sun50i-a64-hdmi-phy
>> >> >
>> >> >      * allwinner,sun8i-a83t-hdmi-phy
>> >> >      * allwinner,sun8i-h3-hdmi-phy
>> >>
>> >> Nit: the list is sorted by family first, then SoC name, so it should
>> >> be the last on the list.
>> >
>> > I went alphabetically, since "5" is before "8"...
>>
>> I see. I think version sort applies here, given that sun50i is newer
>> than sun8i.
>
> Should I make a patch for that?

Yes, please.
