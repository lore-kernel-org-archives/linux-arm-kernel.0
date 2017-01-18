From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 18 Jan 2017 15:38:57 -0800
Subject: [PATCH 2/3] Documentation: devicetree: amlogic: Add R-Box Pro
In-Reply-To: <9439ba55-c56c-71bf-00a5-870e2f4dd07b@suse.de> ("Andreas
 =?utf-8?Q?F=C3=A4rber=22's?= message of "Wed, 18 Jan 2017 23:38:48 +0100")
References: <20170117030611.23827-2-afaerber@suse.de>
 <20170117225459.4438-1-afaerber@suse.de>
 <20170117225459.4438-2-afaerber@suse.de>
 <819ac0c0-92b7-bac7-dcfc-a56c34a6bf62@baylibre.com>
 <9439ba55-c56c-71bf-00a5-870e2f4dd07b@suse.de>
Message-ID: <m2bmv4x7ji.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas F?rber <afaerber@suse.de> writes:

> Am 18.01.2017 um 10:35 schrieb Neil Armstrong:
>> On 01/17/2017 11:54 PM, Andreas F?rber wrote:
>>> Cc: ada at kingnoval.com
>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>> ---
>>>  Originally I thought we would group by SoC (6, 8, 8b, gxbb, gxl, gmx, etc.)
>>>  but this got out of order with nexbox,a95x - so inserting kingnovel between
>>>  amlogic and nexbox here. If that's what we want going forward, we should move
>>>  the old entries to make the scheme clearer. The alternative would be to
>>>  reorder alphabetically within each SoC group, but nexbox,a95x with two SoCs
>>>  makes it difficult to categorize, we could choose gxbb as the earlier one.
>> 
>> Andreas,
>> 
>> Feel free to provide a fixup.
>
> Sure, the question is which way. ;) Kevin? Carlo?

I don't have a strong preference, but continuing to group by SoC makes
the most sense based on what we have there now.

Moving nexbox,a95x up to the first one (gxbb) is fine with me.

Kevin
