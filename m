From: daniel@fooishbar.org (Daniel Stone)
Date: Wed, 23 Dec 2015 10:03:00 +0000
Subject: [PATCH v7 2/4] drm: Add support for ARM's HDLCD controller.
In-Reply-To: <1450806109-470-3-git-send-email-Liviu.Dudau@arm.com>
References: <1450806109-470-1-git-send-email-Liviu.Dudau@arm.com>
 <1450806109-470-3-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <CAPj87rPK4gaFw79poT+Gwfg3R39svdvBTP=GD-E4Lvbm4ysSAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22 December 2015 at 17:41, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> The HDLCD controller is a display controller that supports resolutions
> up to 4096x4096 pixels. It is present on various development boards
> produced by ARM Ltd and emulated by the latest Fast Models from the
> company.

I didn't get to take as close a look as last time, but I only had
fairly minor quibbles then, and nothing jumped out at me this time
either.

Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel
