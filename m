From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 21 Jun 2016 17:30:41 +0200
Subject: [PATCH v4] usb: ohci-at91: Forcibly suspend ports while USB
 suspend
In-Reply-To: <1466472764-29114-1-git-send-email-wenyou.yang@atmel.com>
References: <1466472764-29114-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160621153041.GW5809@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/06/2016 at 09:32:44 +0800, Wenyou Yang wrote :
> In order to save power consumption, as a workaround, forcibly suspend
> the USB PORTA/B/C via setting the SUSPEND_A/B/C bits of OHCI Interrupt
> Configuration Register in the SFR while OHCI USB suspend.
> 
> This suspend operation must be done before the USB clock is disabled,
> resume after the USB clock is enabled.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
