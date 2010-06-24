From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Thu, 24 Jun 2010 20:05:53 +0200
Subject: [PATCH] mx31_3ds: Allow selection between host/device modes on
	the OTG port
In-Reply-To: <343567.80487.qm@web51007.mail.re2.yahoo.com>
References: <343567.80487.qm@web51007.mail.re2.yahoo.com>
Message-ID: <4C239E81.4040805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 2010-06-23 22:52, Fabio Estevam wrote:
> Allow selection between host/device modes on the OTG port.
> 
> Selection is made via kernel command line option:
> 
> 'otg_mode=host' or 'otg_mode=device'. Default mode is device.


Would it be possible to select between host and device during run-time, e.g. when the USB modules are loaded? I'm asking out of curiosity, I don't know if Linux supports this at all.


Regards, Magnus
