From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 1 Oct 2014 16:59:27 +0200
Subject: [PATCH v7 00/11] drm: add support for Atmel HLCDC Display
 Controller
In-Reply-To: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20141001165927.4fc3ab63@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  1 Oct 2014 16:52:57 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hello,
> 
> This series is being sent for several weeks now and I wonder if I shouldn't
> split it in several pieces:
> 1) the MFD driver + its DT doc
> 2) the PWM driver + its DT doc
> 3) the DRM/KMS driver + its DT doc
> 4) support for sama5d3 SoCs/boards
> 
> The first reason for doing this is that Lee already accepted the MFD part,
> and I'm pretty sure he'd like me to stop sending him each new version of this
> series.
> The second reason being that smaller series are more likely to be reviewed by
> subsystem maintainers :-).
> 
> Lee, if you still agree with this version, could you take the MTD part (other

                                                     I meant MFD ^

> drivers in this series depend on it).




-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
