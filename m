From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sun, 22 May 2011 22:41:04 +0200
Subject: [PATCH v2 1/2] MT9P031: Add support for Aptina mt9p031 sensor.
In-Reply-To: <4DD7B630.2080504@redhat.com>
References: <1305899272-31839-1-git-send-email-javier.martin@vista-silicon.com>
	<4DD7B630.2080504@redhat.com>
Message-ID: <201105222241.04385.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

On Saturday 21 May 2011 14:55:12 Mauro Carvalho Chehab wrote:
> Hi Laurent,
> 
> Despite all those changes at Nokia side, I'm still assuming that you're
> handling the omap3 patches.

That's correct. I maintain (with Sakari) the OMAP3 ISP driver. For practical 
reason I'm the one who sends the pull requests.

> So, I'm just marking those two patches as RFC until I receive a pull request
> from you.

Note that this patch is not strictly tied to the OMAP3 ISP, as it adds support 
for a sensor that can be used with any media controller-enabled ISP. In 
practice we don't have many of such ISPs :-) I'll thus take the patch in my 
tree.

> Anyway, in this specific case, Koen made some comments, so we should wait
> for Javier answer before moving ahead.

Guennadi also sent comments. I'll wait for the next version of the patch.

Please note that I will probably apply patch 1/2 only at first, as we still 
have no proper solution to support sensors on pluggable expansion modules in a 
modular way. More work is needed in that area before patch 2/2 (or rather a 
patch set that will provide the same functionality) can be applied.

-- 
Regards,

Laurent Pinchart
