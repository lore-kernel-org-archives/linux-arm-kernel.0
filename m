From: bhumirks@gmail.com (Bhumika Goyal)
Date: Thu, 10 Aug 2017 11:50:45 +0530
Subject: [PATCH 0/3] drm: make drm_connector_funcs structures const
In-Reply-To: <20170809163742.t6vl4rpzarmlyyrh@phenom.ffwll.local>
References: <1502191712-11231-1-git-send-email-bhumirks@gmail.com>
 <3bb03b50-5b73-4fee-2323-d3b67ed3553e@codeaurora.org>
 <20170809163742.t6vl4rpzarmlyyrh@phenom.ffwll.local>
Message-ID: <CAOH+1jEPKTEro=zPO7bzFLdHE_eMF3_n+6sjVWPJ-p-M37+M=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 9, 2017 at 10:07 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Wed, Aug 09, 2017 at 04:02:45PM +0530, Archit Taneja wrote:
>>
>>
>> On 08/08/2017 04:58 PM, Bhumika Goyal wrote:
>> > Declare drm_connector_funcs structures as const.
>>
>> Could you rebase this series over the latest drm-misc-next? The
>> recently merged patch "drm: Nuke drm_atomic_helper_connector_dpms"
>> causes conflicts with these.
>
> I got bored and fixed up the conflicts (wiggle pulled it off). All
> applied, no need to resend.
>

Thank you :)

Thanks,
Bhumika

> Thanks, Daniel
>
>>
>> drm-misc-next:
>>
>> https://cgit.freedesktop.org/drm/drm-misc/log/
>>
>> Thanks,
>> Archit
>>
>> >
>> > Bhumika Goyal (3):
>> >    drm/bridge: make drm_connector_funcs structures const
>> >    drm/sun4i: make drm_connector_funcs structures const
>> >    drm/rockchip: make drm_connector_funcs structures const
>> >
>> >   drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 +-
>> >   drivers/gpu/drm/rockchip/inno_hdmi.c         | 2 +-
>> >   drivers/gpu/drm/sun4i/sun4i_rgb.c            | 2 +-
>> >   drivers/gpu/drm/sun4i/sun4i_tv.c             | 2 +-
>> >   4 files changed, 4 insertions(+), 4 deletions(-)
>> >
>>
>> --
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel at lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
