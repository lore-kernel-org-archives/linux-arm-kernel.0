From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Mon, 3 Apr 2017 10:10:00 +0200
Subject: [Patch v3 07/11] Documentation: v4l: Documentation for HEVC v4l2
 definition
In-Reply-To: <1490951200-32070-8-git-send-email-smitha.t@samsung.com>
References: <1490951200-32070-1-git-send-email-smitha.t@samsung.com>
 <CGME20170331090444epcas5p43f44be426728ea22d0b13f64f5cf05bd@epcas5p4.samsung.com>
 <1490951200-32070-8-git-send-email-smitha.t@samsung.com>
Message-ID: <3bad0b4f-0f0e-c67a-f9f7-135f5b8411c4@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2017 11:06 AM, Smitha T Murthy wrote:
> Add V4L2 definition for HEVC compressed format
> 
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  Documentation/media/uapi/v4l/pixfmt-013.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/media/uapi/v4l/pixfmt-013.rst b/Documentation/media/uapi/v4l/pixfmt-013.rst
> index 728d7ed..ff4cac2 100644
> --- a/Documentation/media/uapi/v4l/pixfmt-013.rst
> +++ b/Documentation/media/uapi/v4l/pixfmt-013.rst
> @@ -90,3 +90,8 @@ Compressed Formats
>        - ``V4L2_PIX_FMT_VP9``
>        - 'VP90'
>        - VP9 video elementary stream.
> +    * .. _V4L2-PIX-FMT-HEVC:
> +
> +      - ``V4L2_PIX_FMT_HEVC``
> +      - 'HEVC'
> +      - HEVC video elementary stream.
> 

You should mention here that HEVC == H.265.

Regards,

	Hans
