From: chris.brand@broadcom.com (Chris Brand)
Date: Mon, 6 Jun 2016 09:42:03 -0700
Subject: [PATCH v2 1/6] power: Introduce Broadcom kona reset driver
In-Reply-To: <20160603023853.GD8921@earth>
References: <1463002582-6875-1-git-send-email-chris.brand@broadcom.com>
 <1463002582-6875-2-git-send-email-chris.brand@broadcom.com>
 <57409633.8060605@gmail.com> <20160603023853.GD8921@earth>
Message-ID: <CAMsMSK8ZX=nmJs9d2txRsk2gLa0duy3Qpp805ztYzow=OiTB8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 2, 2016 at 7:38 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Feel free to queue it via arm-soc with
>
> Acked-By: Sebastian Reichel <sre@kernel.org>
>
> If I didn't overlook it, it's missing DT documentation, though.

Thanks, Sebastian. Because this is effectively a move of code from
arch/arm rather than new code, there's already dt documentation in
Documentation/devicetree/bindings/reset/brcm,bcm21664-resetmgr.txt

Chris
