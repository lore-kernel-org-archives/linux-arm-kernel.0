From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 25 Feb 2015 10:59:48 -0500
Subject: irqchip status (please read)
Message-ID: <20150225155948.GH22772@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

I hate to put the burden on submitters, but I've got to keep the ball
moving.  This will not become the status quo.

Due to changes in my work schedule, I lost track of the status of
submissions during the last cycle and over the merge window.  Normally,
I keep everything irqchip related in one maildir and as I push things,
it gets flagged and I can easily tell what hasn't been handled yet.
Unfortunately, I needed some help from Thomas last window and that
screwed up my system (my fault entirely).

In order to get back on track, I've marked-as-read and archived
everything prior to February 14th.  This is completely arbitrary and not
ideal.  So here is what I have in my queue:

  [PATCH v2 0/6] enhance configuring an ITS
  Yun Wu
  20150215

  [PATCH v3 0/8] irqchip: New driver for ST's SysCfg controlled IRQs
  Lee Jones
  20150218

  [PATCH v5 0/6] irqchip: Move Tegra LIC to use stacked domains
  Marc Zyngier
  20150223

  [RFC PATCH 0/3] genirq: mixing IRQF_NO_SUSPEND and wakeup sources on shared IRQs
  Boris Brezillon
  20150224

  [PATCH v5 0/2] irqchip: Move Exynos PM to use stacked domains
  Marc Zyngier
  20150223

  [PATCH v9 16/21] irqchip: Add GICv2 specific ACPI boot support
  Hanjun Guo
  20150225

  [PATCH v5 0/7] irqchip: Move OMAP{4,5}/DRA7 to use stacked domains
  Marc Zyngier
  20150223

"In my queue" means it's queued up for review, nothing more.

I'm certain there are patches for consideration for this cycle which are
not on the above list.  If they are yours, I ask you to please bear with
me as I get back into the swing of things and please resend as soon as
possible.

Also, since Cc'ing everyone potentially needing to read this would be
unwieldy and error-prone, if you know someone who is affected by this,
please send them a gentle ping and a pointer to this email.

thx,

Jason.
