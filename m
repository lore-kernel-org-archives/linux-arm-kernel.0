From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 30 Sep 2015 16:56:07 +0200
Subject: [PATCH v2 2/7] irq: Export per-cpu irq allocation and
 de-allocation functions
In-Reply-To: <1443197378-30717-3-git-send-email-gregory.clement@free-electrons.com>
References: <1443197378-30717-1-git-send-email-gregory.clement@free-electrons.com>
 <1443197378-30717-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150930165607.1e1ed55d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Some minor typos, quite certainly not worth respining a new iteration
of the series.

On Fri, 25 Sep 2015 18:09:33 +0200, Gregory CLEMENT wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Some drivers might use the per-cpu interrupts and still might be built as a
> module. Export request_percpu_irq an free_percpu_irq to these user, which

an -> and

these user -> these users

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
