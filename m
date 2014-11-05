From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Wed, 5 Nov 2014 16:57:27 +0200
Subject: [PATCH 02/15] [media] v4l: Update subdev-formats doc with new
 MEDIA_BUS_FMT values
In-Reply-To: <1415094910-15899-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1415094910-15899-1-git-send-email-boris.brezillon@free-electrons.com>
 <1415094910-15899-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20141105145726.GR3136@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Tue, Nov 04, 2014 at 10:54:57AM +0100, Boris Brezillon wrote:
> In order to have subsytem agnostic media bus format definitions we've
> moved media bus definition to include/uapi/linux/media-bus-format.h and
> prefixed enum values with MEDIA_BUS_FMT instead of V4L2_MBUS_FMT.
> 
> Update the v4l documentation accordingly.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  Documentation/DocBook/media/Makefile               |   2 +-
>  Documentation/DocBook/media/v4l/subdev-formats.xml | 308 ++++++++++-----------
>  include/uapi/linux/v4l2-mediabus.h                 |   2 +
>  3 files changed, 157 insertions(+), 155 deletions(-)
> 

...

> diff --git a/include/uapi/linux/v4l2-mediabus.h b/include/uapi/linux/v4l2-mediabus.h
> index f471064..9fbe891 100644
> --- a/include/uapi/linux/v4l2-mediabus.h
> +++ b/include/uapi/linux/v4l2-mediabus.h
> @@ -32,6 +32,8 @@ enum v4l2_mbus_pixelcode {
>  	MEDIA_BUS_TO_V4L2_MBUS(RGB888_2X12_BE),
>  	MEDIA_BUS_TO_V4L2_MBUS(RGB888_2X12_LE),
>  	MEDIA_BUS_TO_V4L2_MBUS(ARGB8888_1X32),
> +	MEDIA_BUS_TO_V4L2_MBUS(RGB444_1X12),
> +	MEDIA_BUS_TO_V4L2_MBUS(RGB565_1X16),

Shouldn't this to go to a separate patch?

>  
>  	MEDIA_BUS_TO_V4L2_MBUS(Y8_1X8),
>  	MEDIA_BUS_TO_V4L2_MBUS(UV8_1X8),

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
