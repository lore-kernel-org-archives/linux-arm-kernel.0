From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 23 Aug 2013 10:01:54 -0300
Subject: [PATCH 1/1] ARM: dts: imx28-evk: Add pinctrl for USB OTG ID pin
In-Reply-To: <1377237390-15983-1-git-send-email-peter.chen@freescale.com>
References: <1377237390-15983-1-git-send-email-peter.chen@freescale.com>
Message-ID: <CAOMZO5BvRREYOqhGMxJ2YescQEt1jE1W_iO8GtkmTL-CPgjXow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Fri, Aug 23, 2013 at 2:56 AM, Peter Chen <peter.chen@freescale.com> wrote:
> After that, the dual-role switch can be used at imx28-evk.
>
> Due to hardware limitations, it needs to switch VDD 5V
> SOURCE SELECT to "USB 5V" if the user wants to use OTG
> dual-role switch function. it needs to switch VDD 5V
> SOURCE SELECT to "WALL 5V" if the user wants to Host 1.
>
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

I have already sent this:
http://www.spinics.net/lists/arm-kernel/msg268746.html
