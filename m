From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Mon, 16 Feb 2015 16:48:44 +0000
Subject: [PATCH v5 3/4] media: ov2640: add primary dt support
In-Reply-To: <1423560696-12304-4-git-send-email-josh.wu@atmel.com>
References: <1423560696-12304-1-git-send-email-josh.wu@atmel.com>
 <1423560696-12304-4-git-send-email-josh.wu@atmel.com>
Message-ID: <CA+V-a8vkd2Q714s=o9WZZvPWJQATp=6POb8VYdSgarKxxEKqyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

Thanks for the patch.

On Tue, Feb 10, 2015 at 9:31 AM, Josh Wu <josh.wu@atmel.com> wrote:
[Snip]
>
> -       priv->clk = v4l2_clk_get(&client->dev, "mclk");
> +       priv->clk = v4l2_clk_get(&client->dev, "xvclk");

with this change don?t you need to update the board file using this driver/
the bridge driver ?

Regards,
--Prabhakar Lad
