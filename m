From: sumit.semwal@ti.com (Semwal, Sumit)
Date: Fri, 23 Dec 2011 11:14:34 +0530
Subject: [Linaro-mm-sig] [RFC v3 0/2] Introduce DMA buffer sharing
 mechanism
In-Reply-To: <CAF6AEGt9Ae_zVmhBmmtfyKrqC4EyBgAAO1RWdK_UhY-1RLfOSQ@mail.gmail.com>
References: <1324283611-18344-1-git-send-email-sumit.semwal@ti.com>
 <20111220193117.GD3883@phenom.ffwll.local>
 <CAPM=9tzi5MyCBMJhWBM_ouL=QOaxX3K6KZ8K+t7dUYJLQrF+yA@mail.gmail.com>
 <CAF6AEGt9Ae_zVmhBmmtfyKrqC4EyBgAAO1RWdK_UhY-1RLfOSQ@mail.gmail.com>
Message-ID: <CAB2ybb-CN9-APAqGBjm7tzHDfpuih0vN2Wry1_RqxujxVOy=OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 3:56 AM, Rob Clark <rob@ti.com> wrote:
> On Tue, Dec 20, 2011 at 2:20 PM, Dave Airlie <airlied@gmail.com> wrote:
>>>>
<snip>
>>>
>>> I think this is a really good v1 version of dma_buf. It contains all the
>>> required bits (with well-specified semantics in the doc patch) to
>>> implement some basic use-cases and start fleshing out the integration with
>>> various subsystem (like drm and v4l). All the things still under
>>> discussion like
>>> - userspace mmap support
>>> - more advanced (and more strictly specified) coherency models
>>> - and shared infrastructure for implementing exporters
>>> are imo much clearer once we have a few example drivers at hand and a
>>> better understanding of some of the insane corner cases we need to be able
>>> to handle.
>>>
>>> And I think any risk that the resulting clarifications will break a basic
>>> use-case is really minimal, so I think it'd be great if this could go into
>>> 3.3 (maybe as some kind of staging/experimental infrastructure).
>>>
>>> Hence for both patches:
>>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> Yeah I'm with Daniel, I like this one, I can definitely build the drm
>> buffer sharing layer on top of this.
>>
>> How do we see this getting merged? I'm quite happy to push it to Linus
>> if we don't have an identified path, though it could go via a Linaro
>> tree as well.
>>
>> so feel free to add:
>> Reviewed-by: Dave Airlie <airlied@redhat.com>
>
> fwiw, patches to share buffers between drm and v4l2 are here:
>
> https://github.com/robclark/kernel-omap4/commits/drmplane-dmabuf
>
> (need a bit of cleanup before the vb2 patches are submitted.. but that
> is unrelated to the dmabuf patches)
>
> so,
>
> Reviewed-and-Tested-by: Rob Clark <rob.clark@linaro.org>
Thanks Daniel, Dave, and Rob!
BR,
Sumit.
>
>> Dave.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-media" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
