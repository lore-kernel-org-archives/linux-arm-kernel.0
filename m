From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 11 Dec 2009 20:58:20 +0100
Subject: GPIO support for HTC Dream
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901FB0F92@mi8nycmail19.Mi8.com>
References: <20091208102842.GH12264@elf.ucw.cz>
	<4B1EB57D.6070408@bluewatersys.com>
	<20091208214658.GC4164@elf.ucw.cz>
	<4B1ECEEE.3000209@bluewatersys.com>
	<4B203575.6050407@bluewatersys.com>
	<20091210172458.GJ19454@elf.ucw.cz>
	<4B2150B7.3040207@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901FB0F92@mi8nycmail19.Mi8.com>
Message-ID: <20091211195820.GA1980@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> With this you can now just access the dream_gpio_chip data in all
> the member function using the to_dream_gpio_chip() macro.
> 
> I agree with Ryan and think you would be better off in the long
> run to re-code this and use gpiolib.  You might also want to break
> out all the gpio interrupt stuff and submit it as a seperate patch.

Yep, lets ignore the interrupts, I do not need them for led blinking
:-).

And... thanks!
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
