From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 16 Mar 2015 16:21:41 +0100
Subject: [PATCH] drm: atmel-hlcdc: fixes wrong enabled flag used in PM
 suspend/resume support
In-Reply-To: <1426186039-29646-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1426186039-29646-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <20150316162141.00568c2d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Mar 2015 19:47:19 +0100
Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:

> Unfortunately we used the enabled flag in struct drm_crtc instead of the
> enabled flag in struct atmel_hlcdc_crtc. This obviously leads to
> discrepancies on crtc enable state.
> 
> This patch fixes the issue by using the struct atmel_hlcdc_crtc enabled
> flag in PM support.

Applied to drm-atmel-hlcdc-4.1-fixes with a few modifications to make
checkpatch happy and shorten the subject message.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
