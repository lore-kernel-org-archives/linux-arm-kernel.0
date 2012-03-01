From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 1 Mar 2012 09:53:09 +0000
Subject: ARM: ep93xx: convert vision_ep9307 to MULTI_IRQ_HANDLER
In-Reply-To: <201202291312.21318.hartleys@visionengravers.com>
References: <201202291312.21318.hartleys@visionengravers.com>
Message-ID: <CACb=_tQP8ex7haOAuhMXFghDgscN6QU7YT5+m5fXbdtOas66RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 February 2012 20:12, H Hartley Sweeten
<hartleys@visionengravers.com> wrote:
> As done for the other ep93xx machines in:
>
> commit 9a6879bd902e2ec605fff4d9fb3247b440a1f66a
> ARM: ep93xx: convert to MULTI_IRQ_HANDLER
>
> Now that there is a generic IRQ handler for multiple VIC devices use it
> for vision_ep9307 to help building multi platform kernels.
>
> Signed-off-by: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Jamie Iles <jamie@jamieiles.com>

Reviewed-by: Jamie Iles <jamie@jamieiles.com>
