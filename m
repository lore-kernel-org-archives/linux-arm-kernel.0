From: holgerschurig@gmail.com (Holger Schurig)
Date: Thu, 30 Jul 2015 11:44:52 +0200
Subject: [PATCH v3 0/6] mmc: imx: a few fixes and new feature
In-Reply-To: <20150729091027.GC16916@shlinux1.ap.freescale.net>
References: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
 <20150729091027.GC16916@shlinux1.ap.freescale.net>
Message-ID: <CAOpc7mHjUZeucxvDK6WxKX-tUFTtvsAT72h7BaOzqCwiQEK+Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Can you also fix the driver to NOT use mdelay(1) while in spinlock irqsafe?

A driver with such a design should have gotten a NAK in the first place ...
