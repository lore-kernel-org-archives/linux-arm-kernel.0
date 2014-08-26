From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 26 Aug 2014 09:24:09 +0200
Subject: [PATCHv4 0/4] pwm: imx: support output polarity inversion
In-Reply-To: <1408517756-9412-1-git-send-email-LW@KARO-electronics.de>
References: <1408517756-9412-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20140826092409.7dea5530@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Lothar Wa?mann wrote:
> This patch series adds support for polarity inversion to the pwm-imx
> driver. The patches have been tested on i.MX6, i.MX53 and with the
> ti-ehrpwm.c driver.
> 
> Changes wrt. v2:
> - make the use of '#pwm-cells = <3>' optional, so that the change does
>   not break existing DT blobs as suggested by Arnd Bergmann and Sascha
>   Hauer.
> 
> Changes wrt. v3:
> - implemented the approach suggested by Sascha Hauer 
> - don't modify struct pwm_ops in the imx_pwm probe function
> 
> 
Any further comments?
Anyone taking care of these patches?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
