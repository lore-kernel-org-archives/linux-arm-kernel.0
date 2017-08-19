From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 19 Aug 2017 10:34:34 +0800
Subject: [PATCH 1/8] dt-bindings: phy: sun4i-usb-phy: Add property
 descriptions for H3
In-Reply-To: <7a1889e0-6733-3f7d-4b34-b08e8bf3e2b5@ti.com>
References: <20170803081411.22389-1-wens@csie.org>
 <20170803081411.22389-2-wens@csie.org>
 <20170810170855.txcvwjfb4kzx4q66@rob-hp-laptop>
 <CAGb2v65mKdQC40ASsmeWqCxnDWV4mmf9QFo5-t7spX9RRJBdbg@mail.gmail.com>
 <7a1889e0-6733-3f7d-4b34-b08e8bf3e2b5@ti.com>
Message-ID: <CAGb2v67cMzvmZGMFptkak-M1AT0FNFSX7p-1xqsczMAnO8UFHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 6:53 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi,
>
> On Thursday 17 August 2017 10:35 PM, Chen-Yu Tsai wrote:
>> On Fri, Aug 11, 2017 at 1:08 AM, Rob Herring <robh@kernel.org> wrote:
>>> On Thu, Aug 03, 2017 at 04:14:04PM +0800, Chen-Yu Tsai wrote:
>>>> The Allwinner H3 SoC has 4 USB PHYs, so it needs four sets of pmu
>>>> regions, clocks, resets, and optional vbus properties. These were
>>>> not described when the H3 compatible string was added.
>>>>
>>>> Fixes: 626a630e003c ("phy-sun4i-usb: Add support for the host usb-phys
>>>>                     found on the H3 SoC")
>>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 8 ++++++--
>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>
>> Kishon, are the dt binding and driver parts of this series OK for
>> 4.14? I'd like to get an answer from you to be able to merge the
>> device tree parts.
>
> Yes. I merged the phy driver patches to phy tree. I'm not able to merge the
> dt-bindings patch due to conflicts. Can you resend the dt-binding patch based
> on linux-phy next or let me know if I'm missing any dependent patch.

That's weird. I just applied both patches on top of linux-phy/next and
there were no conflicts or issues. Note that there are two dt binding
patches, patches 1 and 2 in this series. Patch 1 has to be applied before
patch 2

Thanks
ChenYu
