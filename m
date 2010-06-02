From: jason77.wang@gmail.com (jason wang)
Date: Wed, 2 Jun 2010 21:53:26 +0800
Subject: [PATCH 1/3] mxc: Add support for the imx51 3-stack board
References: <82469.38984.qm@web51002.mail.re2.yahoo.com>
Message-ID: <002101cb025b$0775a0e0$9b00a8c0@wuef10f27ebed8>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>Hi Jason,

>--- On Tue, 6/1/10, Jason Wang <jason77.wang@gmail.com> wrote:
>...
>> +static void __init mx51_3ds_timer_init(void)
>> +{
>> + mx51_clocks_init(32768, 24000000, 22579200, 24576000)

>This should be:

>mx51_clocks_init(32768, 24000000, 22579200, 0)
Hi Fabio,
Thanks for your comments, you are right, i checked schematic, the CKIH2 pin is floating.
I will fix it in V2.

Thanks,
Jason.

>Regards,

>Fabio Estevam
