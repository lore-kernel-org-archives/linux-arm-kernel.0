From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 17 Jul 2014 13:00 +0200
Subject: [PATCH v2 3/3] [media] atmel-isi: add primary DT support
In-Reply-To: <53392FC9.9070706@atmel.com>
References: <1395744087-5753-1-git-send-email-josh.wu@atmel.com>
 <Pine.LNX.4.64.1403302313290.12008@axis700.grange>
 <53392FC9.9070706@atmel.com>
Message-ID: <2360323.ktzTJnrmOX@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

What's the status of this patch set ? Do you plan to rebase and resubmit it ?

On Monday 31 March 2014 17:05:13 Josh Wu wrote:
> Dear Guennadi
> 
> On 3/31/2014 5:20 AM, Guennadi Liakhovetski wrote:
> > Hi Josh,
> > 
> > Please correct me if I'm wrong, but I don't see how this is going to work
> > without the central part - building asynchronous V4L2 data structures from
> > the DT, something that your earlier patch
> 
> Here you mean Bryan Wu not me, right?   ;-)
> Bryan write the patch "[v2] media: soc-camera: OF cameras" in:
> https://patchwork.linuxtv.org/patch/22288/.
> And I saw Ben Dooks already sent out his patch to support soc-camera OF
> now (https://patchwork.linuxtv.org/patch/23304/) which is simpler than
> Bryan's.
> 
> > "media: soc-camera: OF cameras"
> > was doing, but which you stopped developing after a discussion with Ben
> > (added to Cc).
> 
> And yes, atmel-isi dt patch should not work without above SoC-Camera of
> support patch.
> But as the atmel-isi dt binding document and port node can be finalized.
> So I think this patch is ready for the mainline.
> 
> BTW: I will test Ben's patch with atmel-isi.

-- 
Regards,

Laurent Pinchart
