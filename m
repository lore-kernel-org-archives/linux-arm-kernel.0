From: robh@kernel.org (Rob Herring)
Date: Wed, 16 Mar 2016 01:44:20 -0500
Subject: [PATCH 1/5] dt/bindings: bcm2835: correct description for DMA-int
In-Reply-To: <1457200973-11662-1-git-send-email-kernel@martin.sperl.org>
References: <1457200973-11662-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <20160316064420.GB16949@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 05, 2016 at 06:02:49PM +0000, kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> The description for interrupt DMA11 and DMA12 are wrong.
> 
> Interrupt DMA11 is the shared interrupt for DMA channels 11 to 14
> Interrupt DMA12 is the shared interrupt triggering for any DMA channel
> (this also includes DMA channel 15)
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Acked-by: Rob Herring <robh@kernel.org>
