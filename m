From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 25 Oct 2016 15:56:55 +0200 (CEST)
Subject: Disabling an interrupt in the handler locks the system up
In-Reply-To: <580F647B.5000202@free.fr>
References: <580A4460.2090306@free.fr>
 <a79e2d2c-8ec8-744f-50fb-8c39216aa23e@arm.com> <580A60ED.3030307@free.fr>
 <20161021201448.3f4a0a7a@arm.com> <580A70B9.8060507@free.fr>
 <alpine.DEB.2.20.1610212147420.4855@nanos> <580A7A2B.5000702@free.fr>
 <20161022123713.6dc788b3@arm.com> <580BF1D4.2030509@free.fr>
 <580E3308.4050507@free.fr> <alpine.DEB.2.20.1610241847580.5002@nanos>
 <580F17E7.5060603@laposte.net> <580F1992.2070602@free.fr>
 <534c4588-f220-25a3-e7aa-84484f348bd1@arm.com>
 <580F647B.5000202@free.fr>
Message-ID: <alpine.DEB.2.20.1610251556280.4990@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Oct 2016, Mason wrote:
> Is the irq_mask() call-back exposed via some module-visible API?

No. And there is no reason to do so.

Thanks,

	tglx
