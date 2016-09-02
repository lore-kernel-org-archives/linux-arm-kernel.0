From: jsarha@ti.com (Jyri Sarha)
Date: Fri, 2 Sep 2016 15:29:27 +0300
Subject: [PATCH 0/3] drm/tilcdc: Some fixes for LCDC rev1
In-Reply-To: <m28tvck2qr.fsf@baylibre.com>
References: <20160823125701.25700-1-kbeldan@baylibre.com>
 <e659bff8-7c8e-35ed-e834-1e00d5c32931@ti.com> <m28tvck2qr.fsf@baylibre.com>
Message-ID: <6ebd85dd-0ffd-ded3-102d-04b80f82c368@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/16 01:11, Kevin Hilman wrote:
> Hi Jyri,
> 
> Jyri Sarha <jsarha@ti.com> writes:
> 
>> On 08/23/16 15:56, Karl Beldan wrote:
>>> Hi,
>>>
>>> I found some missing bits for rev1 of the LCDC and here are some of the
>>> changes I am using to use the DRM driver on an LCDCK (which has a rev1).
>>> 1/3 seems required by rev1 of the IP and without it my the LCDC on my
>>> LCDK keeps can't sync, 2/3 is required by the driver logic, while 3/3
>>> is less of a requirement.
>>
>> I'll drop 3/3, because my recent patches should take care of that:
>> http://www.spinics.net/lists/devicetree/msg138885.html
>>
>> However, there will be v2 round of those patches. Only the DT binding
>> and its default value should change.
>>
>>> Although 1,2/3 would have fitted drm-fixes I based them on drm-next as
>>> 2/3 would conflict with the recent changes in drm-next.
>>>
>>
>> I'll pick these two up for my next pull request. Thanks!
>>
> 
> Can you share a branch which has your current series and these fixes
> included, so we can use that as a baseline for further development?
> 

Hi Kevin,
My pull request from yesterday[1] has all the latest code changes. It is
missing the dts changes, but I don't think you need those. Anyway, if
you do you can pick them from here:
https://github.com/jsarha/linux drm-next-tilcdc-atomic-wip

[1] https://github.com/jsarha/linux tags/tilcdc-4.9-fixes
    or http://www.spinics.net/lists/dri-devel/msg117055.html

Regards,
Jyri
