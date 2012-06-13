From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 13 Jun 2012 18:13:20 +0100
Subject: [PATCH 0/2] ARM: vexpress: Enable SPARSE_IRQ selection
Message-ID: <1339607602-3846-1-git-send-email-tixy@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable vexpress to be included in multiplatform kernels containing
boards which require SPARSE_IRQ, we need to also support this option.
This turns out to be very simple...

[PATCH 1/2] ARM: vexpress: Remove IRQ defines from mach/irq.h
[PATCH 2/2] ARM: vexpress: Enable selection of SPARSE_IRQ
