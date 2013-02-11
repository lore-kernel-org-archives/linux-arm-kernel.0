From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Feb 2013 11:30:54 -0200
Subject: mx28evk does not boot with linux-next 20130207
In-Reply-To: <201302100428.54061.marex@denx.de>
References: <CAOMZO5Ar1T3Lg2KRvSLK-gjNAaAFAf39f6KqaYeF03w5bNj6EQ@mail.gmail.com>
 <20130208164858.GA32318@mudshark.cambridge.arm.com>
 <CAOMZO5CbJfpVwqHM1RSYdEQH4n1EL67Kt2_tC9TNPxZGMsPevQ@mail.gmail.com>
 <201302100428.54061.marex@denx.de>
Message-ID: <CAOMZO5Bkq0aK06LaiyPQ6+nJQRfzhuwVfxa3u9nzO8X2rqJDbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 10, 2013 at 1:28 AM, Marek Vasut <marex@denx.de> wrote:

> Is the amba-pl011 driver maybe broken ?

Running Linus' git I get:

[    0.189156] Serial: AMBA PL011 UART driver
[    0.191187] 80074000.serial: ttyAMA0 at MMIO 0x80074000 (irq = 221)
is a PL011 rev2
[    0.487625] console [ttyAMA0] enabled

,but when I run linux-next only the first line shows up.
