From: robh@kernel.org (Rob Herring)
Date: Tue, 1 May 2018 11:34:51 -0500
Subject: [PATCH 04/21] bindings: display: Add compatible for A64 DE2
 pipeline
In-Reply-To: <CAGb2v66bx2TguLjnMi2R0KFU4=aYC8xveexybnWdWPDd+xwOvg@mail.gmail.com>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-5-jagan@amarulasolutions.com>
 <20180501161723.GA376@rob-hp-laptop>
 <CAGb2v66bx2TguLjnMi2R0KFU4=aYC8xveexybnWdWPDd+xwOvg@mail.gmail.com>
Message-ID: <CAL_JsqJ6PmWJZPjdhHTSMEkKdCiORXKcz3AMch=Nx2Z5FeC3_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 1, 2018 at 11:31 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Wed, May 2, 2018 at 12:17 AM, Rob Herring <robh@kernel.org> wrote:
>> On Mon, Apr 30, 2018 at 05:10:41PM +0530, Jagan Teki wrote:
>>> Allwinner A64 has DE2 pipeline similar to other Allwinner
>>> SOC's like A83T, H3/H5.
>>
>> 'dt-bindings: ' for the subject prefix.
>>
>>>
>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>> ---
>>>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> Otherwise,
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>
> Would it make sense to put all the display component related compatible
> string additions in the same patch? i.e. "Add compatible strings for all
> documented display component blocks". MIPI-DSI is missing, but it's not
> documented.

That's fine by me.

Rob
