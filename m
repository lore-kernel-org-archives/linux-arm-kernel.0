From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 10 Nov 2014 18:25:50 +0100
Subject: [PATCH v6 00/10]  [media] Make mediabus format subsystem neutral
In-Reply-To: <1415640114-14930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1415640114-14930-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20141110182550.18d95bce@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Nov 2014 18:21:44 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hello,
> 
> This patch series prepares the use of media bus formats outside of
> the V4L2 subsytem (my final goal is to use it in the Atmel HLCDC DRM
> driver where I have to configure my DPI/RGB bus according to the
> connected display).
> 
> The series first defines MEDIA_BUS_FMT_ macros, and then replace all
> references to the v4l2_mbus_pixelcode enum and its values within the
> kernel.
> 
> Best Regards,
> 
> Boris
> 
> Changes since v5:
> - fix V4L2_MBUS_FROM_MEDIA_BUS_FMT macro definition

Sorry for the noise, I sent the wrong patch set :-(.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
