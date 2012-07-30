From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 30 Jul 2012 19:27:33 -0300
Subject: [PATCH v6 00/14] add imx usb driver based on Greg next tree
In-Reply-To: <20120626023754.GJ2342@S2101-09.ap.freescale.net>
References: <1340260875-21934-1-git-send-email-richard.zhao@freescale.com>
 <CAOMZO5BEVrPrgZ7E5xUE-_3zXb317mzqoZXaxXw1SNACuRzOPw@mail.gmail.com>
 <20120626023754.GJ2342@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5Bg11-ocEXoOd5W+0hEAHvuVqP6_6CW=rANySDTiNo6SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2012 at 11:37 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Mon, Jun 25, 2012 at 01:18:22PM -0300, Fabio Estevam wrote:
>> Any suggestions as to how to make the driver work on mx23?
>>
> I won't be able to test it on my imx23-evk board, because the board
> design is somehow odd on vbus supply, which probably requires a board
> rework.

Which board rework?

It looks like the 2.6.35 FSL kernel supports USB host on mx23evk
without the need of hardware rework.

Can we try getting USB to work on mx23 too?

Regards,

Fabio Estevam
