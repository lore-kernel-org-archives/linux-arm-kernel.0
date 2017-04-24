From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Apr 2017 22:19:53 +0200
Subject: [PATCH V3 2/2] ARM64: dts: hi6220-hikey: Add clock binding for
 the pmic mfd
In-Reply-To: <20170424201139.GF2137@mai>
References: <1492449567-31399-1-git-send-email-daniel.lezcano@linaro.org>
 <1492449567-31399-2-git-send-email-daniel.lezcano@linaro.org>
 <20170422020233.GA7065@codeaurora.org>
 <370c36f9-e6fc-416c-776b-edc1e42d7ddc@linaro.org>
 <20170424085944.aa5dsc4g6bwm5rgi@dell> <20170424201139.GF2137@mai>
Message-ID: <CAK8P3a24Y+HO=XcGjcXb65PyKkzKRsLJiKQTpntYvpaUuew8Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 10:11 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On Mon, Apr 24, 2017 at 09:59:44AM +0100, Lee Jones wrote:
>> On Sat, 22 Apr 2017, Daniel Lezcano wrote:
>>
>> > On 22/04/2017 04:02, Stephen Boyd wrote:
>> > > On 04/17, Daniel Lezcano wrote:
>> > >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> > >> ---
>> > >>  Documentation/devicetree/bindings/mfd/hisilicon,hi655x.txt | 6 ++++++
>> > >>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts             | 1 +
>> > >>  2 files changed, 7 insertions(+)
>> > >>
>> > >
>> > > I take it this goes through arm-soc? Not sure why I'm on To:
>> > > line.
>> >
>> > Probably it should go through Lee's tree.
>>
>> Unlikely.
>>
>> The document and the DTS change should really have gone separately,
>> but to save you from having to mess around so close to the merge window:
>>
>> Acked-by: Lee Jones <lee.jones@linaro.org>
>
> So who is supposed to take this patch? Xu? Rob?

The DTS file changes should normally go through the platform maintainer
and from there to arm-soc, to minimize the risk for patch conflicts.

For binding changes, conflicts are much rarer, so we any of the tree
(arm-soc, driver subsystem, or devicetree) works equally well IMHO.
In this particular case,keeping the two together is best, so please send
it to Wei Xu with the added chagnelog and Acks.

       Arnd
