From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 01 Dec 2015 16:33:27 +0800
Subject: [RFC PATCH 2/9] drm/rockchip: Use new vblank api drm_crtc_vblank_*
In-Reply-To: <CAPj87rNs+c5Y01zVPF3a+8puFH1ZWuLZUGoDq6EPfDQB5DVZGw@mail.gmail.com>
References: <1448940391-23333-1-git-send-email-mark.yao@rock-chips.com>	<1448940391-23333-3-git-send-email-mark.yao@rock-chips.com>
 <CAPj87rNs+c5Y01zVPF3a+8puFH1ZWuLZUGoDq6EPfDQB5DVZGw@mail.gmail.com>
Message-ID: <565D5B57.4040102@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?12?01? 15:56, Daniel Stone wrote:
> Hi,
>
> On 1 December 2015 at 03:26, Mark Yao <mark.yao@rock-chips.com> wrote:
>> No functional update, drm_vblank_* is the legacy version of
>> drm_crtc_vblank_*. and use new api make driver more clean.
>>
>> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> Heh, I had the same patch in my series to fix pageflip events.
>
> Reviewed-by: Daniel Stone <daniels@collabora.com>
>
> Cheers,
> Daniel
>
>
>

Hi Daniel
    I had picked your patch "[PATCH 1/2] drm/rockchip: Use CRTC vblank 
event interface" into my drm-next, this patch is base on it.

Thanks for your review.

-- 
?ark Yao
