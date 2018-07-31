From: peda@axentia.se (Peter Rosin)
Date: Tue, 31 Jul 2018 09:53:57 +0200
Subject: [PATCH v2 0/7] tda998x: allow use with bridge based devices
In-Reply-To: <20180731074114.GF17271@n2100.armlinux.org.uk>
References: <20180730164137.GD17271@n2100.armlinux.org.uk>
 <73adc630-21cd-5b14-cb47-f1a58ee3bc83@axentia.se>
 <20180731074114.GF17271@n2100.armlinux.org.uk>
Message-ID: <9d48e374-be2f-fbc0-ca92-1b7e1b68e358@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-07-31 09:41, Russell King - ARM Linux wrote:
> On Tue, Jul 31, 2018 at 07:44:24AM +0200, Peter Rosin wrote:
>> On 2018-07-30 18:41, Russell King - ARM Linux wrote:
>>> Hi,
>>>
>>> This is a re-posting of the series I responded to Peter Rosin's May
>>> posting, with a few bugs fixed, and the bridge registered outside of
>>> the component helper.  This should allow Peter to use the driver
>>> while maintaining armada drm and tilcdc support.
>>>
>>> No comments (other than 0-day test results) were received on the
>>> previous posting.
>>
>> I of course meant to comment on this! I didn't because there was a rush
>> before vacation, then vacation, then a heap of important stuff that had
>> piled up. This one simply had too low priority to make a significant bleep
>> on the radar. Sorry for the silence...
>>
>> However, now that I do try to test, I get conflicts as I try to apply the
>> patches. I'm wondering what this was based on? I've tried next-20180730
>> drm-misc/drm-misc-next from some minutes ago.
> 
> They're based on 4.17.

Right, meanwhile I massaged the patches into a combo of some local patches,
next-20180730 and drm-misc-next, and tested that. The conflict was trivial
once I had a closer look...

And it seems to work (with atmel-hlcdc), so you can add

Tested-by: Peter Rosin <peda@axentia.se>

Thank you for very much for picking this up!

Cheers,
Peter
