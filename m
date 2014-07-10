From: galibert@pobox.com (Olivier Galibert)
Date: Thu, 10 Jul 2014 16:30:43 +0200
Subject: [PATCH 1/6] tty: serial: 8250 core: provide a function to export
 uart_8250_port
In-Reply-To: <1404928177-26554-2-git-send-email-bigeasy@linutronix.de>
References: <1404928177-26554-1-git-send-email-bigeasy@linutronix.de>
 <1404928177-26554-2-git-send-email-bigeasy@linutronix.de>
Message-ID: <CAMFK0gtLHrYzWipw=9rp-cUZrKkzBAn_iXSetn016F7zvuZE0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 9, 2014 at 7:49 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> + * The lock assumption made here is none because runtime-pm suspend/resume
> + * callbacks should not be invoked there is any operation performed on the port.

I think there's a missing "if"?

Best,

  OG.
