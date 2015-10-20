From: eric@anholt.net (Eric Anholt)
Date: Tue, 20 Oct 2015 10:45:24 +0100
Subject: [RFC PATCH v3 1/4] drm: Introduce generic probe function for
 component based masters.
In-Reply-To: <1445267270-23126-2-git-send-email-Liviu.Dudau@arm.com>
References: <1445267270-23126-1-git-send-email-Liviu.Dudau@arm.com>
 <1445267270-23126-2-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <87zizdj2kr.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Liviu Dudau <Liviu.Dudau@arm.com> writes:

> A lot of component based DRM drivers use a variant of the same code
> as the probe function. They bind the crtc ports in the first iteration
> and then scan through the child nodes and bind the encoders attached
> to the remote endpoints. Factor the common code into a separate
> function called drm_of_component_probe() in order to increase code
> reuse.
>
> Cc: David Airlie <airlied@linux.ie>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

Acked-by: Eric Anholt <eric@anholt.net>

I'm unimpressed with of-graph, but this will really help me in trying it
out for vc4.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151020/89fac9af/attachment-0001.sig>
