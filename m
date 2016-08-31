From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 31 Aug 2016 15:11:40 -0700
Subject: [PATCH 0/3] drm/tilcdc: Some fixes for LCDC rev1
In-Reply-To: <e659bff8-7c8e-35ed-e834-1e00d5c32931@ti.com> (Jyri Sarha's
 message of "Tue, 23 Aug 2016 19:24:42 +0300")
References: <20160823125701.25700-1-kbeldan@baylibre.com>
 <e659bff8-7c8e-35ed-e834-1e00d5c32931@ti.com>
Message-ID: <m28tvck2qr.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jyri,

Jyri Sarha <jsarha@ti.com> writes:

> On 08/23/16 15:56, Karl Beldan wrote:
>> Hi,
>> 
>> I found some missing bits for rev1 of the LCDC and here are some of the
>> changes I am using to use the DRM driver on an LCDCK (which has a rev1).
>> 1/3 seems required by rev1 of the IP and without it my the LCDC on my
>> LCDK keeps can't sync, 2/3 is required by the driver logic, while 3/3
>> is less of a requirement.
>
> I'll drop 3/3, because my recent patches should take care of that:
> http://www.spinics.net/lists/devicetree/msg138885.html
>
> However, there will be v2 round of those patches. Only the DT binding
> and its default value should change.
>
>> Although 1,2/3 would have fitted drm-fixes I based them on drm-next as
>> 2/3 would conflict with the recent changes in drm-next.
>> 
>
> I'll pick these two up for my next pull request. Thanks!
>

Can you share a branch which has your current series and these fixes
included, so we can use that as a baseline for further development?

Thanks,

Kevin
