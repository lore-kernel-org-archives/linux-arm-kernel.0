From: hjc@rock-chips.com (Sandy Huang)
Date: Mon, 27 Nov 2017 10:22:11 +0800
Subject: [PATCH] MAINTAINERS: change maintainer for Rockchip drm drivers
In-Reply-To: <20171124145106.hdtybw3hgizlg6gs@phenom.ffwll.local>
References: <1510568131-28838-1-git-send-email-mark.yao@rock-chips.com>
 <20171120074848.cg22qkved232pxxf@phenom.ffwll.local>
 <83984459.7UdiCfbSkg@phil>
 <20171124145106.hdtybw3hgizlg6gs@phenom.ffwll.local>
Message-ID: <f69c94b4-f9d7-ac35-4d88-261f27d84d17@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,
     I register the account and get the drm-misc commit rights now, thanks.

? 2017/11/24 22:51, Daniel Vetter ??:
> On Fri, Nov 24, 2017 at 09:28:59AM +0100, Heiko Stuebner wrote:
>> Hi Daniel,
>>
>> [somehow my email address seems to have gotten lost, so
>> only saw this by chance on the list itself now.
>> I've also re-added Sandy to the recipients]
>>
>> Am Montag, 20. November 2017, 08:48:48 CET schrieb Daniel Vetter:
>>> On Mon, Nov 13, 2017 at 06:15:31PM +0800, Mark Yao wrote:
>>>> For personal reasons, Mark Yao will leave rockchip,
>>>> can not continue maintain drm/rockchip, Sandy Huang
>>>> will take over the drm/rockchip.
>>>>
>>>> Cc: Sandy Huang <hjc@rock-chips.com>
>>>> Cc: Heiko Stuebner <heiko@sntech.de>
>>>>
>>>> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
>>>
>>> Since rockchip is in drm-misc that means we need a new maintainer who also
>>> has drm-misc commit rights. Sandy doesn't yet, so if Sandy is going to be
>>> the new maintainer we need to fix that.
>>>
>>> Also, Heiko, are you interested in becoming co-maintainer? With commit
>>> rights and all.
>>
>> I always feel somewhat inadequate judging the fast-paced drm stuff, as in
>> the past once I got my head wrapped around something, drm always
>> somehow moved another mile already ;-) .
>>
>> But somewhere I read that drm-pace for big changes is supposed to slow a
>> bit now that atomic modesetting is done in a lot of places, so we could give
>> co-maintainership for the Rockchip-drm a try - with Sandy wearing the
>> actual hat for big changes though ;-) .
> 
> Yeah I think on the modeset side it calmed down a lot. We're still
> fine-tuning the helper libraries as we're figuring out better ways to
> write drivers. But right now I think a lot of the action is all in details
> not relevant for many drivers.
> 
> If Sandy's ok with that too pls request an fd.o account for drm-misc and
> set up the tooling per our quickstart guide:
> 
> https://01.org/linuxgraphics/gfx-docs/maintainer-tools/dim.html#quickstart
> 
> Thanks, Daniel
> 
