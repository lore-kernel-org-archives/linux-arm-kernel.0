From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 19 Jan 2017 17:02:39 +0100
Subject: [PATCH 1/2] dt-bindings: gpu: Add Mali Utgard bindings
In-Reply-To: <20170119155103.e6hctoqllfgypesm@lukather>
References: <20170116132424.7038-1-maxime.ripard@free-electrons.com>
 <20170116184906.r62di7xiil5lae33@kozik-lap>
 <20170117093813.mxp2hgoxbgske6ru@lukather>
 <4f5b8608-af6c-3ef5-aaf0-e7e034d006cd@baylibre.com>
 <20170119155103.e6hctoqllfgypesm@lukather>
Message-ID: <9b9f7542-9a13-9f76-502d-85abb1d45a80@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2017 04:51 PM, Maxime Ripard wrote:
> Hi Neil,
> 
> On Tue, Jan 17, 2017 at 11:22:22AM +0100, Neil Armstrong wrote:
>> On 01/17/2017 10:38 AM, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Mon, Jan 16, 2017 at 08:49:06PM +0200, Krzysztof Kozlowski wrote:
>>>> On Mon, Jan 16, 2017 at 02:24:23PM +0100, Maxime Ripard wrote:
>>>>> The ARM Mali Utgard GPU family is embedded into a number of SoCs from
>>>>> Allwinner, Amlogic, Mediatek or Rockchip.
>>>>>
>>>>> Add a binding for the GPU of that family.
>>>>>
>>>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>>>> ---
>>>>>  .../devicetree/bindings/gpu/arm,mali-utgard.txt    | 76 ++++++++++++++++++++++
>>>>>  1 file changed, 76 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
>>>>
>>>> Do you have a driver in kernel which will implement these bindings?
>>>
>>> No, but we have bindings for out-of-tree drivers already.
>>>
>>>> Defining them for out-of-tree driver does not bring any benefits
>>>> (3rd party driver will not respect them anyway).
>>>
>>> You could see it the other way around too. The out-of-tree drivers
>>> don't respect it at the moment because there's no binding to respect.
>>>
>>> And at least for us, we definitely plan on doing that.
>>>
>>> Maxime
>>
>> Hi Maxime, Krzysztof,
>>
>> We hope this will be accepted so it will solve the same issue we
>> have on Amlogic SoCs and all the other mali powered SoCs.
> 
> Do you have any requirements (or weird case) that is not covered by
> the current doc?
> 
> Thanks,
> Maxime
> 

Hi Maxime,

Apart the GPU DVFS, all is covered by the current doc for the Amlogic Meson GXBB and GXL SoCs.

Neil

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170119/869ba77a/attachment.sig>
