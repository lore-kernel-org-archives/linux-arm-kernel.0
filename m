From: narkewoody@gmail.com (Woody Wu)
Date: Thu, 6 Dec 2012 02:57:34 +0000 (UTC)
Subject: s3c2410 lcd driver maximum resolution?
Message-ID: <slrnkc02b3.4ir.narkewoody@zuhnb712.local.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, list

Does anyone know what's the maximum display resolution I can expect for
the s3c2410-lcd frame buffer driver (s3c2410fb.c)? I am about to use
8bpp color mode only.

Is there any other requirements for the LCD module to ensure it
compatiable with s3c2410+Linux? One thing I am thinking is, that since
the s3c2410 already has a buid in LCD controller, so there is no
controller needed in the LCD module side, this should give me a chance
to use a low price LCD other than those kind of expensive LCD which
embedded a processor.  Do I understand right?


Thanks in advance.


-- 
woody
I can't go back to yesterday - because I was a different person then.
