From: daniel@fooishbar.org (Daniel Stone)
Date: Tue, 1 Dec 2015 07:56:00 +0000
Subject: [RFC PATCH 2/9] drm/rockchip: Use new vblank api drm_crtc_vblank_*
In-Reply-To: <1448940391-23333-3-git-send-email-mark.yao@rock-chips.com>
References: <1448940391-23333-1-git-send-email-mark.yao@rock-chips.com>
 <1448940391-23333-3-git-send-email-mark.yao@rock-chips.com>
Message-ID: <CAPj87rNs+c5Y01zVPF3a+8puFH1ZWuLZUGoDq6EPfDQB5DVZGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 1 December 2015 at 03:26, Mark Yao <mark.yao@rock-chips.com> wrote:
> No functional update, drm_vblank_* is the legacy version of
> drm_crtc_vblank_*. and use new api make driver more clean.
>
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>

Heh, I had the same patch in my series to fix pageflip events.

Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel
