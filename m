From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 1 Dec 2015 10:01:27 +0100
Subject: [RFC PATCH 2/9] drm/rockchip: Use new vblank api drm_crtc_vblank_*
In-Reply-To: <565D5B57.4040102@rock-chips.com>
References: <1448940391-23333-1-git-send-email-mark.yao@rock-chips.com>
 <1448940391-23333-3-git-send-email-mark.yao@rock-chips.com>
 <CAPj87rNs+c5Y01zVPF3a+8puFH1ZWuLZUGoDq6EPfDQB5DVZGw@mail.gmail.com>
 <565D5B57.4040102@rock-chips.com>
Message-ID: <20151201090127.GN17050@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 04:33:27PM +0800, Mark yao wrote:
> On 2015?12?01? 15:56, Daniel Stone wrote:
> >Hi,
> >
> >On 1 December 2015 at 03:26, Mark Yao <mark.yao@rock-chips.com> wrote:
> >>No functional update, drm_vblank_* is the legacy version of
> >>drm_crtc_vblank_*. and use new api make driver more clean.
> >>
> >>Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> >Heh, I had the same patch in my series to fix pageflip events.
> >
> >Reviewed-by: Daniel Stone <daniels@collabora.com>
> >
> >Cheers,
> >Daniel
> >
> >
> >
> 
> Hi Daniel
>    I had picked your patch "[PATCH 1/2] drm/rockchip: Use CRTC vblank event
> interface" into my drm-next, this patch is base on it.

That really should be mentioned in the commit message, and you must keep
the signed-off-by chain intact when adapting or reusing other peoples
work.
-Daniel

> 
> Thanks for your review.
> 
> -- 
> ?ark Yao
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
