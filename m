From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 2 Oct 2015 15:57:32 +0200
Subject: [PATCH 1/2] pinctrl: at91-pio4: Use irq_set_handler_locked()
In-Reply-To: <abf74f93ec58e3b321dce23af3fa5af1ffa2e070.1443793711.git.nicolas.ferre@atmel.com>
References: <abf74f93ec58e3b321dce23af3fa5af1ffa2e070.1443793711.git.nicolas.ferre@atmel.com>
Message-ID: <560E8D4C.1000400@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Well it seems my cover letter is missing. So, here it is:

---8<----
pinctrl: at91-pio4: fixes for current linux-next (irq)

While testing the sama5d2 on today's linux-next I discovered that some
adaptations were missing. So, I don't know if you were aware but here
are my fixes in case you don't have them already.

+Cc: Thomas and Stephen in case these errors happen while building
linux-next...

Bye,
