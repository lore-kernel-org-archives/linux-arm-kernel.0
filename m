From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 28 Sep 2009 09:43:57 +0200
Subject: S3C64xx backlight PWM misinited GPIO pin
In-Reply-To: <4ABB8EEE.7070103@gmail.com> (Maurus Cuelenaere's message of
	"Thu\, 24 Sep 2009 17\:23\:26 +0200")
References: <4ABB8EEE.7070103@gmail.com>
Message-ID: <87iqf3sede.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Maurus" == Maurus Cuelenaere <mcuelenaere@gmail.com> writes:

 Maurus> Hi,

 Maurus> Are the GPIO pins used as PWM (e.g. GPF15) supposed to be set
 Maurus> to special function 2 in the bootloader/mach file or is this
 Maurus> just a bug in the PWM driver in current mainline?

The pin configuration imho doesn't belong in the pwm driver shared
between 24xx/64xx.

 Maurus> which doesn't look like it's the way to go..

To me it's OK - Ben, what do you say?

 Maurus> Do I need to set some kind of config option (mach-hmt doesn't
 Maurus> seem to need the above change) or .. ?

It doesn't do it because I setup the pin in the bootloader (E.G. to
display bootsplash image).

-- 
Bye, Peter Korsgaard
