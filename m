From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sun, 15 Jul 2012 14:11:11 +0200
Subject: [PATCH] media: mx2_camera: Remove MX2_CAMERA_SWAP16 and
 MX2_CAMERA_PACK_DIR_MSB flags.
In-Reply-To: <1342083809-19921-1-git-send-email-javier.martin@vista-silicon.com>
References: <1342083809-19921-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <9522639.Z8oXnMrKic@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Thursday 12 July 2012 11:03:29 Javier Martin wrote:
> These flags are not used any longer and can be safely removed
> since the following patch:
> http://www.spinics.net/lists/linux-media/msg50165.html
>
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

I would replace the URL with the commit ID in mainline. Apart from that,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
