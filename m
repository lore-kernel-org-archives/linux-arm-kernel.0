From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 19 Feb 2017 22:28:12 +0100
Subject: [PATCH v4 12/36] add mux and video interface bridge entity
 functions
In-Reply-To: <1487211578-11360-13-git-send-email-steve_longerbeam@mentor.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-13-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170219212812.GA28347@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2017-02-15 18:19:14, Steve Longerbeam wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> - renamed MEDIA_ENT_F_MUX to MEDIA_ENT_F_VID_MUX
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>

This is slightly "interesting" format of changelog. Normally signoffs
go below.

> diff --git a/Documentation/media/uapi/mediactl/media-types.rst b/Documentation/media/uapi/mediactl/media-types.rst
> index 3e03dc2..023be29 100644
> --- a/Documentation/media/uapi/mediactl/media-types.rst
> +++ b/Documentation/media/uapi/mediactl/media-types.rst
> @@ -298,6 +298,28 @@ Types and flags used to represent the media graph elements
>  	  received on its sink pad and outputs the statistics data on
>  	  its source pad.
>  
> +    -  ..  row 29
> +
> +       ..  _MEDIA-ENT-F-MUX:
> +
> +       -  ``MEDIA_ENT_F_MUX``

And you probably want to rename it here, too.

With that fixed:

Reviewed-by: Pavel Machek <pavel@ucw.cz>
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170219/b1c5bf01/attachment.sig>
