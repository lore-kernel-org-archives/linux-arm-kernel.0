From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 19 Nov 2014 12:20:53 +0100
Subject: [PATCH V8 00/14] drm/exynos: few patches to enhance bridge chip
 support
In-Reply-To: <20141119105527.GA5396@luxor.wired.org>
References: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
 <CAEC9eQOrKw2Z1q-ztFfadXmsL3CTcAkkv9kcS2QnDOAVSh2AuQ@mail.gmail.com>
 <546C646C.4060303@collabora.co.uk> <20141119105527.GA5396@luxor.wired.org>
Message-ID: <546C7D15.10605@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Paolo,

On 11/19/2014 11:55 AM, Paolo Pisati wrote:
> to get a working framebuffer out of linus 318rc4 on my peach pi, i had
> to cherry pick these 3 patches:
> 
> arm: dts: Exynos5: Use pmu_system_controller phandle for dp phy

I was missing this patch, I've display working now. Thanks for the pointer!

If someone else is interested, I've pushed a branch [0] with 3.18-rc5 + all
the needed patches.

Ajay, feel free to add to your series:

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier

[0]: git://git.collabora.co.uk/git/user/javier/linux.git wip/exynos/dp-integ
