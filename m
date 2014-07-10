From: menon.nishanth@gmail.com (menon.nishanth at gmail.com)
Date: Thu, 10 Jul 2014 11:14:28 -0500
Subject: [PATCH 6/6] tty: serial: Add 8250-core based omap driver
In-Reply-To: <53BEB951.2040207@ti.com>
References: <1404928177-26554-1-git-send-email-bigeasy@linutronix.de>
 <1404928177-26554-7-git-send-email-bigeasy@linutronix.de>
 <20140710070948.GH28884@atomide.com>
 <53BEB5AF.7010604@linutronix.de> <53BEB951.2040207@ti.com>
Message-ID: <CAGo_u6r57s6kpF81W-hq96PFizOp3m+XEh3bmzJOp0oPHYRNCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 11:03 AM, Carlos Hernandez <ceh@ti.com> wrote:
> 1) Append no_console_suspend to bootargs
Not needed. ideally with pinctrl wakeup capability, this should work.
if you do no_console_suspend, the module is not powered down.
