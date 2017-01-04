From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 4 Jan 2017 17:02:55 +0530
Subject: [PATCH v6 0/5] davinci: VPIF: add DT support
In-Reply-To: <57057847.C5XnZnHN9E@avalon>
References: <20161207183025.20684-1-khilman@baylibre.com>
 <d4b0501a-f83a-c8b1-e460-1ba50f68cca7@xs4all.nl>
 <4a03b56e-1e01-8b2c-c2a1-1b72d30f103a@ti.com> <57057847.C5XnZnHN9E@avalon>
Message-ID: <82a21ded-822d-6fda-1dd7-d3dac076c3ba@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Mauro

On Tuesday 03 January 2017 02:42 PM, Laurent Pinchart wrote:
> Hi Sekhar,
> 
> On Tuesday 03 Jan 2017 14:33:00 Sekhar Nori wrote:
>> On Friday 16 December 2016 03:17 PM, Hans Verkuil wrote:
>>> On 07/12/16 19:30, Kevin Hilman wrote:
>>>> Prepare the groundwork for adding DT support for davinci VPIF drivers.
>>>> This series does some fixups/cleanups and then adds the DT binding and
>>>> DT compatible string matching for DT probing.
>>>>
>>>> The controversial part from previous versions around async subdev
>>>> parsing, and specifically hard-coding the input/output routing of
>>>> subdevs, has been left out of this series.  That part can be done as a
>>>> follow-on step after agreement has been reached on the path forward.
>>>> With this version, platforms can still use the VPIF capture/display
>>>> drivers, but must provide platform_data for the subdevs and subdev
>>>> routing.
>>>>
>>>> Tested video capture to memory on da850-lcdk board using composite
>>>> input.
>>>
>>> Other than the comment for the first patch this series looks good.
>>>
>>> So once that's addressed I'll queue it up for 4.11.
>>
>> Can you provide an immutable commit (as it will reach v4.11) with with
>> this series applied? I have some platform changes to queue for v4.11
>> that depend on the driver updates.
> 
> I don't think that's possible, given that Mauro rewrites all patches when 
> handling pull requests to prepend [media] to the subject line and to add his 
> SoB. Only Mauro can thus provide a stable branch, Hans can't.

Hi Mauro, once Hans sends you these patches, can you host these patches
on a stable branch, which I can merge into my pull request to ARM-SoC. I
have some platform updates that depend on these driver changes.

Ideally the branch has only these patches over an early v4.10-rc so I
include as little of media stuff as possible in my pull request.

Thanks,
Sekhar
