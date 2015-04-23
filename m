From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 23 Apr 2015 07:55:36 -0300
Subject: [PATCH] ARM: dts: imx25: Add missing '#pwm-cells' property for
 pwm4
In-Reply-To: <20150422141449.GI21413@pengutronix.de>
References: <1429706430-9495-1-git-send-email-fabio.estevam@freescale.com>
 <20150422141449.GI21413@pengutronix.de>
Message-ID: <CAOMZO5CyU6nLwdD-dBKQRma6fCxD99-GHXDUYe0D_8ECnDZhrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Wed, Apr 22, 2015 at 11:14 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> Hi Fabio,
>
> On Wed, Apr 22, 2015 at 09:40:30AM -0300, Fabio Estevam wrote:
>> All pwm ports pass the '#pwm-cells' property, except pw4.
>>
>> Fix it by passing '#pwm-cells' property for pwm4.
>
> I already sent the same patch a month ago [1]. Forgot to resend it.

Ok, I haven't seen it. Could you please resend it with stable on Cc?

Thanks
