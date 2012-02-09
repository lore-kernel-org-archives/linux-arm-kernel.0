From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 9 Feb 2012 17:04:34 -0600
Subject: [PATCH v2 3/4] ARM: make entry-macro.S depend on
 !MULTI_IRQ_HANDLER
In-Reply-To: <1328751219-2552-4-git-send-email-robherring2@gmail.com>
References: <1328751219-2552-1-git-send-email-robherring2@gmail.com>
 <1328751219-2552-4-git-send-email-robherring2@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41F9DF640@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 08, 2012 6:34 PM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> With the removal of disable_fiq on rpc and addition MULTI_IRQ_HANDLER,
> entry-macro.S is no longer needed for platforms that select
> MULTI_IRQ_HANDLER and the include of it can be conditional.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

For ep93xx:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
