From: tfiga@chromium.org (Tomasz Figa)
Date: Tue, 17 Jan 2017 18:32:44 +0900
Subject: [PATCH] drm/rockchip: vop: make vop register setting take effect
In-Reply-To: <57C3A341.9030302@rock-chips.com>
References: <1472269178-16593-1-git-send-email-zyw@rock-chips.com>
 <57C3A341.9030302@rock-chips.com>
Message-ID: <CAAFQd5CP8ERvJzchZo0=5gvuUuP+EBiyfhKDkgRYBa8iQYW0Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Aug 29, 2016 at 11:51 AM, Mark yao <mark.yao@rock-chips.com> wrote:
> On 2016?08?27? 11:39, Chris Zhong wrote:
>>
>> The setting of vop registers need a reg_done writing to take effect.
>> In vop_enable the vop return to work by by restoring registers, but the
>> registers do not take effect immediately, it should a vop_cfg_done
>> after it. The same thing is needed by windows_disabled in
>> vop_crtc_disable.
>>
>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>> ---
>>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>
> Thanks for your fix.
>
> applied to my drm-fixes.

This patch seems to have been lost in action. I don't see it in linux-next.

Best regards,
Tomasz
