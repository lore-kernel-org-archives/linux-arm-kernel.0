From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 21 Nov 2012 12:00:43 +0900
Subject: [PATCH 9/9] ARM: remove mach .handle_irq for VIC users
In-Reply-To: <1353466713-18967-10-git-send-email-robherring2@gmail.com>
References: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
 <1353466713-18967-10-git-send-email-robherring2@gmail.com>
Message-ID: <20121121030036.GK4673@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 08:58:33PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Now that the VIC initialization sets up the handle_arch_irq pointer, we
> can remove it for all machines and make it static.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121121/bc58e2a5/attachment.sig>
