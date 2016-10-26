From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 26 Oct 2016 09:02:14 -0700
Subject: [PATCH] ARM: davinci: da850: Fix pwm name matching
In-Reply-To: <f423a705-5ae2-78cf-2b63-609dd4e2cdf6@ti.com> (Sekhar Nori's
 message of "Wed, 26 Oct 2016 16:07:29 +0530")
References: <1477418044-24603-1-git-send-email-david@lechnology.com>
 <f423a705-5ae2-78cf-2b63-609dd4e2cdf6@ti.com>
Message-ID: <7heg33rtdl.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

Sekhar Nori <nsekhar@ti.com> writes:

> On Tuesday 25 October 2016 11:24 PM, David Lechner wrote:
>> This fixes pwm name matching for DA850 familiy devices. When using device
>> tree, the da850_auxdata_lookup[] table caused pwm devices to have the exact
>> same name, which caused errors when trying to register the devices.
>> 
>> The names for clock matching in da850_clks[] also have to be updated to
>> to exactly match in order for the clock lookup to work correctly.
>> 
>> Signed-off-by: David Lechner <david@lechnology.com>
>
> Applied to "fixes" branch. Will send upstream after testing a bit and
> also waiting to see if anyone else has any comments.

I'm not seeing a fixes branch in your tree.  Did you push this out?
Similarily, I didn't see the updates in v4.10/defconfig either.

Kevin
