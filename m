From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 18 Aug 2017 14:19:38 +0800
Subject: [linux-sunxi] [PATCH 4/4] drivers: soc: sunxi: add support for
 A64 and its SRAM C
In-Reply-To: <CAGb2v66RnXDbL7OJfOAgeXPJSFZwzgfGbnB108vX-+OO_0xiWQ@mail.gmail.com>
References: <20170809085627.32687-1-icenowy@aosc.io>
 <20170809085627.32687-5-icenowy@aosc.io>
 <CAGb2v66RnXDbL7OJfOAgeXPJSFZwzgfGbnB108vX-+OO_0xiWQ@mail.gmail.com>
Message-ID: <CAGb2v65U1Bdo_reLhh2977CkATkTwuL_6-tDK6UrV=N5OyQKcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 5:48 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Wed, Aug 9, 2017 at 4:56 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> Allwinner A64's display engine claims the SRAM C section to work.
>>
>> Add support for the A64 SRAM controller and the SRAM C section of it.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>
> Looks good to me. Will apply all 4 once the dt bindings are acked.

Applied patch 1, 3, and 4 for 4.14, and patch 2 as a fix for 4.13.

Thanks
ChenYu
