From: mail@pawelmoll.com (Pawel Moll)
Date: Wed, 28 Jul 2010 10:06:12 +0100
Subject: JPEG hw decoder
In-Reply-To: <AANLkTin4r_NrQbzXoTWoJJRCUXX9mjfgtrJ9yTPLW5_W@mail.gmail.com>
References: <AANLkTin4r_NrQbzXoTWoJJRCUXX9mjfgtrJ9yTPLW5_W@mail.gmail.com>
Message-ID: <1280307972.28571.12.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>       My board has a hardware JPEG decoder. I want to write a driver
> for this in Linux kernel, But it seems there that no Framework exists
> in kernel. Can somebody provide me some pointers?

If I was to do the same, I'd look around V4L2 API. If covers things like
video encoders/decoders etc. The only problem is that the particular
area you are interested in is not well defined yet:

http://linuxtv.org/downloads/v4l-dvb-apis/ch04s05.html

This means that people usually extend the API in their own way, staying
within the framework itself, obviously.

Maybe you could ask about this on the linux-media mailing list?

http://vger.kernel.org/vger-lists.html#linux-media

Good luck!

Pawe?
