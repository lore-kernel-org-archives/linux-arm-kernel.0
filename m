From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 10 Feb 2015 13:06:18 -0200
Subject: [PATCH V2 RESEND] clk: mxs: Fix invalid 32-bit access to frac
 registers
In-Reply-To: <54DA0DE7.5050708@i2se.com>
References: <1422645610-3052-1-git-send-email-stefan.wahren@i2se.com>
 <CAOMZO5DOgdUYsRUU3TXgJY+JhjF8xC_XY8EJFcrM7NHiPmSMOQ@mail.gmail.com>
 <54DA020C.6030703@i2se.com>
 <CAOMZO5DGCP1p1vetwWHpSbe2qywA8DhWRRq22egMDFSw11uq4w@mail.gmail.com>
 <54DA0DE7.5050708@i2se.com>
Message-ID: <CAOMZO5AtFOThRjcAgMVbrbkcrJbehouSxoH03VUGJrRdWXnS_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Tue, Feb 10, 2015 at 11:55 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Could you apply only the clk-imx28.c part of my patch and see what happens?

If I apply only the clk-imx28.c part of your patch I can successfully
probe the SPI NOR.

Thanks
