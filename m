From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Jun 2012 09:24:51 -0300
Subject: [Patch v5 00/13] add imx usb driver for mx28/6x
In-Reply-To: <20120619061414.GD21951@S2101-09.ap.freescale.net>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <CAOMZO5BXsPtwC2CTt6Z-DjZUYhrWMKDkr2QnFoAKb-aLc1XsNA@mail.gmail.com>
 <201206181913.06886.marex@denx.de>
 <CAOMZO5DF+CH+qe+VKc4vefkj05aXOtn0nVZK9vx+0kakP_em1A@mail.gmail.com>
 <20120619061414.GD21951@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5A+eWXsz5_HGzUMJBDKnADrMeWPec7XvX+EMPJMtqWcng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, Jun 19, 2012 at 3:14 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

>> Attached my .config file.
>>
> You haven't enabled the following two in your .config.
>
> CONFIG_USB_CHIPIDEA
> CONFIG_USB_CHIPIDEA_HOST

Please check my config file again:

It does have:

CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_HOST=y

Can someone confirm that this patch series works on a mx28evk? If it
does, please send me the .config that works.

Thanks,

Fabio Estevam
