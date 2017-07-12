From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 12 Jul 2017 10:40:16 +0800
Subject: [PATCH v3] drm/sun4i: Implement drm_driver lastclose to restore
 fbdev console
In-Reply-To: <20170711192131.mdmkvgxgzo7bwywe@flea>
References: <20170710065504.31497-1-net147@gmail.com>
 <20170711192131.mdmkvgxgzo7bwywe@flea>
Message-ID: <CAGb2v64svM2KB7dtf+USM=LppHrnvYiV-AobZubB8D3T6u=9Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 12, 2017 at 3:21 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, Jul 10, 2017 at 04:55:04PM +1000, Jonathan Liu wrote:
>> The drm_driver lastclose callback is called when the last userspace
>> DRM client has closed. Call drm_fbdev_cma_restore_mode to restore
>> the fbdev console otherwise the fbdev console will stop working.
>>
>> Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
>> Cc: stable at vger.kernel.org
>> Signed-off-by: Jonathan Liu <net147@gmail.com>
>> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>
> Queued for 4.14, thanks!

May we have this sooner? Like 4.13? :)

ChenYu
