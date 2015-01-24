From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 24 Jan 2015 17:37:48 +0100 (CET)
Subject: [PATCH v3 0/5] ARM: at91: fix irq_pm_install_action WARNING
In-Reply-To: <1422032971-14139-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1422032971-14139-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <alpine.DEB.2.11.1501241735530.5526@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Jan 2015, Boris Brezillon wrote:
>  - change the compatible string to clearly show that this chip is purely
>    virtual

So we probably want to do : s/dumb/virt/ for both DT and code to make
it clear from the names as well.

Thanks,

	tglx
