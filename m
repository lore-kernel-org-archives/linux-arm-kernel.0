From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 11 Mar 2018 23:27:41 +0100
Subject: [PATCH v1 3/5] dt-bindings: clock: add clocks for MT2712
In-Reply-To: <1519957404.14513.5.camel@mtksdaap41>
References: <20180222054851.26096-1-weiyi.lu@mediatek.com>
 <20180222054851.26096-5-weiyi.lu@mediatek.com>
 <20180301224555.44pvl67l5oqibbkg@rob-hp-laptop>
 <1519957404.14513.5.camel@mtksdaap41>
Message-ID: <d1f7b0e7-fa9b-cc87-80df-3479db8b9281@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/02/2018 03:23 AM, Weiyi Lu wrote:
> On Thu, 2018-03-01 at 16:45 -0600, Rob Herring wrote:
>> On Thu, Feb 22, 2018 at 01:48:49PM +0800, Weiyi Lu wrote:
>>> add new clocks according to ECO design change
>>>
>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>>> ---
>>>  include/dt-bindings/clock/mt2712-clk.h | 294 +++++++++++++++++----------------
>>>  1 file changed, 151 insertions(+), 143 deletions(-)
>>
>> You can't just renumber your clocks. They are an ABI. Plus, for an ECO 
>> there can't have been that much change.
>>
> Hi Rob,
> Got it! Is it correct if I append those new added clocks at the bottom
> of each own subsystem? If the answer is yes, I'll resend a new version.

Yes, that will work. Please do that and resubmit.

Thanks,
Matthias
