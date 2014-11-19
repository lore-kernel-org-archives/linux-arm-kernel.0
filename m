From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 19 Nov 2014 17:28:54 +0100
Subject: [PATCH V8 00/14] drm/exynos: few patches to enhance bridge chip
 support
In-Reply-To: <20141119162224.GB5396@luxor.wired.org>
References: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
 <CAEC9eQOrKw2Z1q-ztFfadXmsL3CTcAkkv9kcS2QnDOAVSh2AuQ@mail.gmail.com>
 <546C646C.4060303@collabora.co.uk> <20141119105527.GA5396@luxor.wired.org>
 <546C7D15.10605@collabora.co.uk> <20141119162224.GB5396@luxor.wired.org>
Message-ID: <546CC546.5090900@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Paolo,

On 11/19/2014 05:22 PM, Paolo Pisati wrote:
> On Wed, Nov 19, 2014 at 12:20:53PM +0100, Javier Martinez Canillas wrote:
>> 
>> If someone else is interested, I've pushed a branch [0] with 3.18-rc5 + all
>> the needed patches.
>> 
>> Ajay, feel free to add to your series:
>> 
>> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> 
>> Best regards,
>> Javier
>> 
>> [0]: git://git.collabora.co.uk/git/user/javier/linux.git wip/exynos/dp-integ
> 
> doesn't peach pi require the same dts modification as peach pit/snow?
> 

No, because the Peach Pit and Snow have an eDP to LVDS bridge chip but the
Peach Pi does not have a bridge. Ajay's series is to add DRM bridge support
to Exynos Display Port driver and so is only relevant to Snow and Pit.

Best regards,
Javier
