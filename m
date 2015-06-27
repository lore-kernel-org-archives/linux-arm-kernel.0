From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 27 Jun 2015 17:48:20 -0300
Subject: imx: apf27: the board no longer boot with latest git kernel
In-Reply-To: <558F09B3.9050907@gmail.com>
References: <558EA370.6020108@gmail.com>
 <CAOMZO5AcRd8UJQg9MpV6mXJKkB2JMriGHzzKYS95oWQYzMOsuw@mail.gmail.com>
 <558EDCB2.9040603@gmail.com>
 <CAOMZO5DbL8etNQAb4vOwsXSQr2SBWMzCx0P7+TUWj54T9ZrSjg@mail.gmail.com>
 <CAOMZO5DgrV-divVoAa3K5QOLdxChewpGcKRLbDjMPRtpx_8KNQ@mail.gmail.com>
 <558F09B3.9050907@gmail.com>
Message-ID: <CAOMZO5AEXB3BnXUey7=svBP1omsmKETtZyZCJ4viS3eMiZF6kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

On Sat, Jun 27, 2015 at 5:38 PM, Philippe Reynes <tremyfr@gmail.com> wrote:

> I've tested this change, and it works fine.
> In the file drivers/clocksource/timer-imx-gpt.c, there is :
> #define imx21_gpt_irq_disable imx1_gpt_irq_disable
> #define imx21_gpt_irq_enable imx1_gpt_irq_enable
> So I think that using imx1 or imx21 has the same result;
>
> Do you think I should put both change in on patch ?
> Or is it better to do two patches please ?

I think they should be separate patches.

Let's do the following: you sent the
drivers/clocksource/timer-imx-gpt.c fix and I will send the dtsi
change.

Thanks,

Fabio Estevam
