From: airlied@gmail.com (Dave Airlie)
Date: Wed, 21 Jan 2015 10:23:43 +1000
Subject: [GIT PULL] drm: Add Atmel HLCDC driver
In-Reply-To: <20150116150940.GC7775@ulmo.nvidia.com>
References: <20150109160342.715d3592@bbrezillon>
 <20150116150940.GC7775@ulmo.nvidia.com>
Message-ID: <CAPM=9twEBETA2_w+5B43Kx_KpYyVvMqRC_6fJNUn=gnFyt5Cpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

can you update with Thierry's acks and send again, I'll pull it then.

Dave.

On 17 January 2015 at 01:09, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Fri, Jan 09, 2015 at 04:03:42PM +0100, Boris Brezillon wrote:
>> Dave, Thierry,
>>
>> Here is the pull request for the Atmel HLCDC driver and its
>> dependencies (some modifications to drm/core and drm/panel to define
>> output bus format).
>>
>> I'm sending a pull request for this driver for several reasons:
>>
>>  * The patch series has been around for 6 months (initial version here
>>    [3]), and has seen 9 iterations, taking into account comments made
>>    by reviewers.
>>
>>  * It has received several Tested-by by various users/developers.
>>
>>  * It has been Reviewed-by Rob Clark.
>>
>>  * There has been no comment whatsoever since more than a month (see
>>    [1] and [2] for the last modified version of these series).
>>
>> I'll be happy to take comments into account if any. But if there are no
>> more comments, please merge for 3.20.
>>
>> Best Regards,
>>
>> Boris
>>
>> [1]https://lkml.org/lkml/2014/12/1/717
>> [2]http://thread.gmane.org/gmane.comp.video.dri.devel/118700
>> [3]https://lkml.org/lkml/2014/6/9/487
>>
>> The following changes since commit c93546a5e32bd788c22aefa072385f3784551c13:
>>
>>   Merge tag 'topic/atomic-core-2015-01-05' of git://anongit.freedesktop.org/drm-intel into drm-next (2015-01-09 09:22:40 +1000)
>>
>> are available in the git repository at:
>>
>>
>>   https://github.com/bbrezillon/linux-at91.git tags/atmel-hlcdc-drm-3.20
>>
>> for you to fetch changes up to e7f6614add3dc7776abd803be7cbe96b6254b3f5:
>>
>>   drm: add DT bindings documentation for atmel-hlcdc-dc driver (2015-01-09 14:55:08 +0100)
>>
>> ----------------------------------------------------------------
>> Boris Brezillon (5):
>>       drm: add bus_formats and num_bus_formats fields to drm_display_info
>>       drm: panel: simple-panel: add support for bus_format retrieval
>>       drm: panel: simple-panel: add bus format information for foxlink panel
>>       drm: add Atmel HLCDC Display Controller support
>>       drm: add DT bindings documentation for atmel-hlcdc-dc driver
>
> For patches 1 to 3:
>
>         Acked-by: Thierry Reding <treding@nvidia.com>
>
> For patches 4 and 5, I don't have the time to properly review them, but
> from a very quick glance I couldn't spot anything completely out of the
> ordinary, so I think it'd be okay to merge these for v3.20.
>
> Thierry
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
