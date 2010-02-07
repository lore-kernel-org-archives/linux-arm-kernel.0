From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Sun, 7 Feb 2010 11:10:53 -0800 (PST)
Subject: [PATCHv3 5/7] mxc: Add support for the Babbage board (i.MX5)
In-Reply-To: <ef6149ed5e1d228262c3d98421a836400095c1b7.1265385421.git.amit.kucheria@canonical.com>
Message-ID: <229789.92421.qm@web51008.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amit,

...

--- On Fri, 2/5/10, Amit Kucheria <amit.kucheria@canonical.com> wrote:
> +static void __init mx51_babbage_timer_init(void)
> +{
> +??? mx51_clocks_init(32768, 24000000, 22579200, 24576000);
> +}

Would you care to comment about the values of the last two parameters of this function?

Regards,

Fabio Estevam


      
