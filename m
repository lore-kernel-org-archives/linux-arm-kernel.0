From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 1 Jul 2013 11:12:48 -0300
Subject: [alsa-devel] [PATCH 1/4] ASoC: sgtl5000: give it a ramping time
 before writting
In-Reply-To: <201307011254.18952.marex@denx.de>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <1372666571-17276-2-git-send-email-shawn.guo@linaro.org>
 <20130701100710.GB27646@sirena.org.uk>
 <201307011254.18952.marex@denx.de>
Message-ID: <CAOMZO5BAs5-Tf_O0TVLFAuCchVuukV+bH2MpjqMU83tTw2GD=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 1, 2013 at 7:54 AM, Marek Vasut <marex@denx.de> wrote:

> The delay might also be caused by the I2C driver, I have this in my ToDo to

Yes, this extra delay could be related to the mxs i2c driver, as we do
not need to add this delay when using sgtl5000 on other i.mx devices.

Other people have also reported mxs i2c issues currently:
http://marc.info/?l=linux-i2c&m=137241339917261&w=2

,so this may be related some how.

Regards,

Fabio Estevam
