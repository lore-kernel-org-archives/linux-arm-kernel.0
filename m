From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 18 Aug 2017 16:23:36 +0530
Subject: [PATCH 1/8] dt-bindings: phy: sun4i-usb-phy: Add property
 descriptions for H3
In-Reply-To: <CAGb2v65mKdQC40ASsmeWqCxnDWV4mmf9QFo5-t7spX9RRJBdbg@mail.gmail.com>
References: <20170803081411.22389-1-wens@csie.org>
 <20170803081411.22389-2-wens@csie.org>
 <20170810170855.txcvwjfb4kzx4q66@rob-hp-laptop>
 <CAGb2v65mKdQC40ASsmeWqCxnDWV4mmf9QFo5-t7spX9RRJBdbg@mail.gmail.com>
Message-ID: <7a1889e0-6733-3f7d-4b34-b08e8bf3e2b5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 17 August 2017 10:35 PM, Chen-Yu Tsai wrote:
> On Fri, Aug 11, 2017 at 1:08 AM, Rob Herring <robh@kernel.org> wrote:
>> On Thu, Aug 03, 2017 at 04:14:04PM +0800, Chen-Yu Tsai wrote:
>>> The Allwinner H3 SoC has 4 USB PHYs, so it needs four sets of pmu
>>> regions, clocks, resets, and optional vbus properties. These were
>>> not described when the H3 compatible string was added.
>>>
>>> Fixes: 626a630e003c ("phy-sun4i-usb: Add support for the host usb-phys
>>>                     found on the H3 SoC")
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>  Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> Acked-by: Rob Herring <robh@kernel.org>
> 
> Kishon, are the dt binding and driver parts of this series OK for
> 4.14? I'd like to get an answer from you to be able to merge the
> device tree parts.

Yes. I merged the phy driver patches to phy tree. I'm not able to merge the
dt-bindings patch due to conflicts. Can you resend the dt-binding patch based
on linux-phy next or let me know if I'm missing any dependent patch.

Thanks
Kishon
