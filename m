From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 7 Aug 2018 15:31:03 +0800
Subject: [PATCH 1/5] dt-binding: dwmac-sun8i: add H6 compatible string (w/
 A64 fallback)
In-Reply-To: <20180731205614.GA25776@rob-hp-laptop>
References: <20180722053955.25266-1-icenowy@aosc.io>
 <20180722053955.25266-2-icenowy@aosc.io>
 <20180731205614.GA25776@rob-hp-laptop>
Message-ID: <CAGb2v67rOsxKxxRB0Yc8NugzmBas5s1aXmVBgh1Ts9AGd_OgEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 1, 2018 at 4:56 AM, Rob Herring <robh@kernel.org> wrote:
> On Sun, Jul 22, 2018 at 01:39:51PM +0800, Icenowy Zheng wrote:
>> The Allwinner H6 SoC features a Ethernet MAC that is similar to the one
>> in A64.
>>
>> Add a compatible string for it with A64 fallback compatible string, in
>> this case the A64 driver can be used.
>>
>> The "internal" PHY is not internal from the perspective of the H6 main
>> die, instead it's on the co-packaged AC200 chip, and connected to the
>> main die with RMII at the in-package Port A PIO bank. So from the SoC
>> driver side it needs no special treatment.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 1 +
>>  1 file changed, 1 insertion(+)
>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
