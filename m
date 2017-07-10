From: net147@gmail.com (Jonathan Liu)
Date: Mon, 10 Jul 2017 16:53:56 +1000
Subject: [PATCH v2] drm/sun4i: Implement drm_driver lastclose to restore
 fbdev console
In-Reply-To: <20170710064412.xpadh4p64krvohvi@flea>
References: <20170709075951.16690-1-net147@gmail.com>
 <CAGb2v67s=_Z_zcvpMmNZOmZ+y+J5EoxiAVfWpQ+UUxQipUe=sw@mail.gmail.com>
 <20170710064412.xpadh4p64krvohvi@flea>
Message-ID: <CANwerB062Ph52oFsKw6Uz_jrvnNAY24xWm_8tL3sK566hKYhbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 10 July 2017 at 16:44, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sun, Jul 09, 2017 at 11:11:07PM +0800, Chen-Yu Tsai wrote:
>> On Sun, Jul 9, 2017 at 3:59 PM, Jonathan Liu <net147@gmail.com> wrote:
>> > The drm_driver lastclose callback is called when the last userspace
>> > DRM client has closed. Call drm_fbdev_cma_restore_mode to restore
>> > the fbdev console otherwise the fbdev console will stop working.
>> >
>> > Signed-off-by: Jonathan Liu <net147@gmail.com>
>>
>> This should have
>>
>> Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
>>
>> Otherwise,
>>
>> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>
> And it should be sent to stable too.
>
> Can you resend it?

Will do.

>
> Thanks!
> Maxime
>
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

Regards,
Jonathan
