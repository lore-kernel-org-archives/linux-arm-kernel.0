From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 26 Nov 2012 11:26:08 -0600
Subject: [PATCH 9/9] ARM: remove mach .handle_irq for VIC users
In-Reply-To: <1353466713-18967-10-git-send-email-robherring2@gmail.com>
References: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
 <1353466713-18967-10-git-send-email-robherring2@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206B26459EF@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 20, 2012 7:59 PM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Now that the VIC initialization sets up the handle_arch_irq pointer, we
> can remove it for all machines and make it static.
>

For ep93xx:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
