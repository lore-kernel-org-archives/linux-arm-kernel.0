From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Jun 2015 13:28:51 +0200
Subject: [RFT v2 45/48] genirq,
 gpio: Kill the first parameter 'irq' of irq_flow_handler_t
In-Reply-To: <1433391238-19471-46-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
 <1433391238-19471-46-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <CACRpkdafGYG3Bt+0Xe4z=5NOoaRK-c-ViOUvJ3P_9yeZg0tLLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 4, 2015 at 6:13 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:

> Now most IRQ flow handlers make no use of the first parameter 'irq'.
> And for those who do make use of 'irq', we could easily get the irq
> number through irq_desc->irq_data->irq. So kill the first parameter
> 'irq' of irq_flow_handler_t.
>
> To ease review, I have split the changes into several parts, though
> they should be merge as one to support bisecting.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
