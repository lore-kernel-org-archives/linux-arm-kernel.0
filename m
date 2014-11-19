From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Wed, 19 Nov 2014 17:44:14 +0100
Subject: [PATCH V8 00/14] drm/exynos: few patches to enhance bridge chip
 support
In-Reply-To: <546CC546.5090900@collabora.co.uk>
References: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
 <CAEC9eQOrKw2Z1q-ztFfadXmsL3CTcAkkv9kcS2QnDOAVSh2AuQ@mail.gmail.com>
 <546C646C.4060303@collabora.co.uk> <20141119105527.GA5396@luxor.wired.org>
 <546C7D15.10605@collabora.co.uk> <20141119162224.GB5396@luxor.wired.org>
 <546CC546.5090900@collabora.co.uk>
Message-ID: <546CC8DE.3050208@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 19.11.2014 um 17:28 schrieb Javier Martinez Canillas:
> On 11/19/2014 05:22 PM, Paolo Pisati wrote:
>> On Wed, Nov 19, 2014 at 12:20:53PM +0100, Javier Martinez Canillas wrote:
>>>
>>> If someone else is interested, I've pushed a branch [0] with 3.18-rc5 + all
>>> the needed patches.
>>>
>>> Ajay, feel free to add to your series:
>>>
>>> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>>
>>> Best regards,
>>> Javier
>>>
>>> [0]: git://git.collabora.co.uk/git/user/javier/linux.git wip/exynos/dp-integ
>>
>> doesn't peach pi require the same dts modification as peach pit/snow?
>>
> 
> No, because the Peach Pit and Snow have an eDP to LVDS bridge chip but the
> Peach Pi does not have a bridge. Ajay's series is to add DRM bridge support
> to Exynos Display Port driver and so is only relevant to Snow and Pit.

... and to Spring.

So, what's the timing here - is this series headed for 3.20 now or 3.19?

Regards,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg
