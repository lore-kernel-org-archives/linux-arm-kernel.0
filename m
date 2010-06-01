From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Tue, 1 Jun 2010 08:35:06 -0700 (PDT)
Subject: [PATCH 1/3] mxc: Add support for the imx51 3-stack board
In-Reply-To: <1275405043-18230-2-git-send-email-jason77.wang@gmail.com>
Message-ID: <82469.38984.qm@web51002.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

--- On Tue, 6/1/10, Jason Wang <jason77.wang@gmail.com> wrote:
...
> +static void __init mx51_3ds_timer_init(void)
> +{
> +??? mx51_clocks_init(32768, 24000000, 22579200, 24576000)

This should be:

mx51_clocks_init(32768, 24000000, 22579200, 0)

Regards,

Fabio Estevam


      
