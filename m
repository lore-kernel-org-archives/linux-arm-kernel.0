From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 10 Feb 2015 11:09:19 -0200
Subject: [PATCH V2 RESEND] clk: mxs: Fix invalid 32-bit access to frac
 registers
In-Reply-To: <54DA020C.6030703@i2se.com>
References: <1422645610-3052-1-git-send-email-stefan.wahren@i2se.com>
 <CAOMZO5DOgdUYsRUU3TXgJY+JhjF8xC_XY8EJFcrM7NHiPmSMOQ@mail.gmail.com>
 <54DA020C.6030703@i2se.com>
Message-ID: <CAOMZO5DGCP1p1vetwWHpSbe2qywA8DhWRRq22egMDFSw11uq4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Tue, Feb 10, 2015 at 11:05 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

> sorry no. But i will try to get a mx28evk to reproduce the problem and

Just a comment: mx28evk comes without SPI NOR flash from the factory.
I have populated one in my mx28evk (slot U49).

> narrow down which part of the patch causes this problem.
>
> Did you see any problem with the clock control register settings?

I haven't inspected the clock control registers yet.

Regards,

Fabio Estevam
