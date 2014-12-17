From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 17 Dec 2014 00:44:06 -0200
Subject: [PATCH RFC] clk: mxs: Fix invalid 32-bit access to frac registers
In-Reply-To: <1638147247.144508.1418577377536.JavaMail.open-xchange@oxbaltgw03.schlund.de>
References: <1418570933-21585-1-git-send-email-stefan.wahren@i2se.com>
 <201412141712.12589.marex@denx.de>
 <1638147247.144508.1418577377536.JavaMail.open-xchange@oxbaltgw03.schlund.de>
Message-ID: <CAOMZO5CQjpYtrNTT65-ikJua4N_osYj4UVgm3EV+sEvVWF59cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Sun, Dec 14, 2014 at 3:16 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Btw i hope this patch also fixes a SPI communication issue with our hardware
> which forces us to bypass ref_io1 for ssp2.

Does this patch fix the SPI issue?
