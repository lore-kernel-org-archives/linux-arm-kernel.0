From: libv@skynet.be (Luc Verhaegen)
Date: Wed, 26 Aug 2015 11:44:39 +0200
Subject: [PATCH v2 1/7] drm/vc4: Add devicetree bindings for VC4.
In-Reply-To: <1439934848-7196-2-git-send-email-eric@anholt.net>
References: <1439934848-7196-1-git-send-email-eric@anholt.net>
 <1439934848-7196-2-git-send-email-eric@anholt.net>
Message-ID: <20150826094438.GB2032@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 02:54:02PM -0700, Eric Anholt wrote:
> VC4 is the GPU (display and 3D) subsystem present on the 2835 and some
> other Broadcom SoCs.
> ...
> +Broadcom VC4 GPU
> +
> +The VC4 device present on the Raspberry Pi includes a display system
> +with HDMI output and the HVS scaler for compositing display planes.

Is this a direct hw driver implementation, banging registers, or is this 
talking to the os/firmware/binary blob running on the videocore dsp?

Luc Verhaegen.
