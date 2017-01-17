From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 17 Jan 2017 18:06:59 +0800
Subject: [PATCH] drm/rockchip: vop: make vop register setting take effect
In-Reply-To: <CAAFQd5CP8ERvJzchZo0=5gvuUuP+EBiyfhKDkgRYBa8iQYW0Kw@mail.gmail.com>
References: <1472269178-16593-1-git-send-email-zyw@rock-chips.com>
 <57C3A341.9030302@rock-chips.com>
 <CAAFQd5CP8ERvJzchZo0=5gvuUuP+EBiyfhKDkgRYBa8iQYW0Kw@mail.gmail.com>
Message-ID: <587DECC3.50304@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz

I had sent to Dave, but maybe something is wrong, it miss.

the patch is on this pull-request:
https://lists.freedesktop.org/archives/dri-devel/2016-September/118505.html

I forgot to double check it, I will resend to Dave soon.

Thanks.

On 2017?01?17? 17:32, Tomasz Figa wrote:
> Hi Mark,
>
> On Mon, Aug 29, 2016 at 11:51 AM, Mark yao <mark.yao@rock-chips.com> wrote:
>> On 2016?08?27? 11:39, Chris Zhong wrote:
>>> The setting of vop registers need a reg_done writing to take effect.
>>> In vop_enable the vop return to work by by restoring registers, but the
>>> registers do not take effect immediately, it should a vop_cfg_done
>>> after it. The same thing is needed by windows_disabled in
>>> vop_crtc_disable.
>>>
>>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>>> ---
>>>    drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>> Thanks for your fix.
>>
>> applied to my drm-fixes.
> This patch seems to have been lost in action. I don't see it in linux-next.
>
> Best regards,
> Tomasz
>
>
>


-- 
?ark Yao
