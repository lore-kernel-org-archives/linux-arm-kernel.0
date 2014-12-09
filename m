From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 9 Dec 2014 11:03:40 +0800
Subject: [PATCH 4/5] media: ov2640: add a master clock for sensor
In-Reply-To: <CAOMZO5ASNUCz908esJ3iTQ6VEQGeNi-HOmqMOf12c633Q8pavw@mail.gmail.com>
References: <1418038147-13221-1-git-send-email-josh.wu@atmel.com>	<1418038147-13221-5-git-send-email-josh.wu@atmel.com>
 <CAOMZO5ASNUCz908esJ3iTQ6VEQGeNi-HOmqMOf12c633Q8pavw@mail.gmail.com>
Message-ID: <5486668C.3000808@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

On 12/8/2014 11:10 PM, Fabio Estevam wrote:
> On Mon, Dec 8, 2014 at 9:29 AM, Josh Wu <josh.wu@atmel.com> wrote:
>
>> +       priv->master_clk = devm_clk_get(&client->dev, "xvclk");
>> +       if (IS_ERR(priv->master_clk))
>> +               return -EINVAL;
> You should return PTR_ERR(priv->master_clk) instead.
sure. I'll fix it in next version. Thanks.

Best Regards,
Josh Wu
