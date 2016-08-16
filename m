From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 16 Aug 2016 13:52:48 +0100
Subject: [PATCH 1/1] rpmsg: virtio_rpmsg_bus: Fix randomly placed
 semi-colon
In-Reply-To: <20160720092935.5902-1-lee.jones@linaro.org>
References: <20160720092935.5902-1-lee.jones@linaro.org>
Message-ID: <20160816125248.GA2775@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Jul 2016, Lee Jones wrote:

> It should never have been there in the first place.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm assuming this was missed.  Would you like me to send it again, or
do you have the original patch still in your inbox?

> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index fe03b2a..9823178 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -865,7 +865,7 @@ static void rpmsg_recv_done(struct virtqueue *rvq)
>  		msgs_received++;
>  
>  		msg = virtqueue_get_buf(rvq, &len);
> -	};
> +	}
>  
>  	dev_dbg(dev, "Received %u messages\n", msgs_received);
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
