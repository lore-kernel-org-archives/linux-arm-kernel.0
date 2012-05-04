From: cjb@laptop.org (Chris Ball)
Date: Fri, 04 May 2012 09:26:02 -0400
Subject: [PATCH 6.2/7] MMC: mmci: Enable Device Tree support for ux500
In-Reply-To: <4FA3D720.7010004@linaro.org> (Lee Jones's message of "Fri, 04
 May 2012 14:18:24 +0100")
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
 <4F8BE5B0.4000900@linaro.org>
 <20120425185747.GC24211@n2100.arm.linux.org.uk>
 <4FA29E46.6040204@linaro.org>
 <20120503151253.GE897@n2100.arm.linux.org.uk>
 <4FA2A4A8.9010208@linaro.org>
 <20120503163008.GF897@n2100.arm.linux.org.uk>
 <4FA2B4A3.2040402@linaro.org>
 <20120503164501.GG897@n2100.arm.linux.org.uk>
 <8762cdur7o.fsf@laptop.org> <4FA3D720.7010004@linaro.org>
Message-ID: <87mx5ot6vp.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 04 2012, Lee Jones wrote:
> I can either do that, or push it through Arnd's tree if you like (and
> it's okay with him), as I will be supplying him with another pull
> request after my next patch-set has been scrutinised. Would that suit
> you better?

If the MMC patches are self-contained and it doesn't break anything to
merge them separately, my preference is to merge them via the MMC tree
(to avoid creating conflicts against other MMC patches in there).

If there are dependencies, going via Arnd instead is fine.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
