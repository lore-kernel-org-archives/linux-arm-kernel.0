From: jhnikula@gmail.com (Jarkko Nikula)
Date: Mon, 21 Feb 2011 09:54:21 +0200
Subject: [PATCH resend] omap: rx51: Add SI4713 FM transmitter
In-Reply-To: <AANLkTikR5v9_G3oyRjVP1oCcBo=hU+ikywximd=VDbDd@mail.gmail.com>
References: <1298040354-1726-1-git-send-email-jhnikula@gmail.com>
	<1298270556-11571-1-git-send-email-jhnikula@gmail.com>
	<AANLkTikR5v9_G3oyRjVP1oCcBo=hU+ikywximd=VDbDd@mail.gmail.com>
Message-ID: <20110221095421.6576a98d.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Feb 2011 13:10:59 +0530
"Varadarajan, Charulatha" <charu@ti.com> wrote:

> > + ? ? ? err = gpio_request_one(RX51_FMTX_IRQ, GPIOF_DIR_IN, "si4713 irq");
> > + ? ? ? if (err) {
> > + ? ? ? ? ? ? ? printk(KERN_ERR "Cannot request si4713 irq gpio. %d\n", err);
> 
> use pr_err instead of printk.
> 
Thanks, I was obviously blind, will send an update :-)

-- 
Jarkko
