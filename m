From: ykk@rock-chips.com (Yakir Yang)
Date: Sat, 31 Oct 2015 11:15:47 +0800
Subject: [PATCH v8 09/17] dt-bindings: add document for rockchip variant
 of analogix_dp
In-Reply-To: <CAL_JsqLxkz43gj-O+r0LURg0_41SrDB7g8EAHwjxbytoUPijhA@mail.gmail.com>
References: <1446020143-32645-1-git-send-email-ykk@rock-chips.com>
 <1446020905-10670-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqLxkz43gj-O+r0LURg0_41SrDB7g8EAHwjxbytoUPijhA@mail.gmail.com>
Message-ID: <56343263.7090401@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 10/31/2015 12:46 AM, Rob Herring wrote:
> On Wed, Oct 28, 2015 at 3:28 AM, Yakir Yang <ykk@rock-chips.com> wrote:
>> Rockchip DP driver is a helper driver of analogix_dp coder driver,
>> so most of the DT property should be descriped in analogix_dp document.
>>
>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> ---
> Looks mostly fine to me.
>
> [...]
>
>> +- rockchip,grf: this soc should set GRF regs, so need get grf here.
>> +
>> +- ports: contain a port node with endpoint definitions as defined in
>> +  Documentation/devicetree/bindings/media/video-interfaces.txt.
> Please document that you have 2 ports 0 and 1, port0 has 2 endpoints
> for ? and port1 has 1 endpoint connected to a panel(or another
> bridge). Otherwise that is only evident from the example.

Okay, looks great.

Thanks,
- Yakir

> Rob
>
>
>
