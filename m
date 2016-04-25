From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Apr 2016 08:50:07 -0500
Subject: [PATCH 14/41] Documentation: dt: media: fix spelling mistake
In-Reply-To: <1461543878-3639-15-git-send-email-eric@engestrom.ch>
References: <1461543878-3639-1-git-send-email-eric@engestrom.ch>
 <1461543878-3639-15-git-send-email-eric@engestrom.ch>
Message-ID: <20160425135007.GA8585@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 01:24:11AM +0100, Eric Engestrom wrote:
> Signed-off-by: Eric Engestrom <eric@engestrom.ch>

Applied, thanks.

Rob

> ---
>  Documentation/devicetree/bindings/media/xilinx/video.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/xilinx/video.txt b/Documentation/devicetree/bindings/media/xilinx/video.txt
> index cbd46fa..68ac210 100644
> --- a/Documentation/devicetree/bindings/media/xilinx/video.txt
> +++ b/Documentation/devicetree/bindings/media/xilinx/video.txt
> @@ -20,7 +20,7 @@ The following properties are common to all Xilinx video IP cores.
>  - xlnx,video-format: This property represents a video format transmitted on an
>    AXI bus between video IP cores, using its VF code as defined in "AXI4-Stream
>    Video IP and System Design Guide" [UG934]. How the format relates to the IP
> -  core is decribed in the IP core bindings documentation.
> +  core is described in the IP core bindings documentation.
>  
>  - xlnx,video-width: This property qualifies the video format with the sample
>    width expressed as a number of bits per pixel component. All components must
> -- 
> 2.8.0
> 
