From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 25 Jan 2016 12:09:31 +0100
Subject: [PATCH 1/2] drm/rockchip: Don't build rockchip_drm_vop as modules
In-Reply-To: <1453719247.30130.22.camel@collabora.co.uk>
References: <1452673328-29188-1-git-send-email-mark.yao@rock-chips.com>
 <1452673328-29188-2-git-send-email-mark.yao@rock-chips.com>
 <1453719247.30130.22.camel@collabora.co.uk>
Message-ID: <4712230.210ZLu46G4@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 25. Januar 2016, 11:54:07 schrieb Sjoerd Simons:
> On Wed, 2016-01-13 at 16:22 +0800, Mark Yao wrote:
> > rockchip_drm_vop's module init had moved to rockchip_vop_reg.c
> > so no need to build rockchip_drm_vop.ko
> 
> Looks like this didn't make it for the Linux 4.5 merge window, which
> unfortunately means in 4.5-rc1 DRM on rockchip is broken :/

but it is in the fixes pull request Mark sent to Dave on friday
