From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Apr 2013 16:56:53 +0200
Subject: [PATCH 04/10] usb: musb: ux500: harden checks for platform data
In-Reply-To: <CAF2Aj3ga7R3Vti4YB-83T_AsanB3iL34aysAN3MiMWZBvB=z2Q@mail.gmail.com>
References: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
 <20130424142615.GF23081@arwen.pp.htv.fi>
 <CAF2Aj3ga7R3Vti4YB-83T_AsanB3iL34aysAN3MiMWZBvB=z2Q@mail.gmail.com>
Message-ID: <201304241656.53432.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 April 2013, Lee Jones wrote:
> Yeah, I agree, although does it make a difference?
> 
> Is it evaluated a second time, or does it take up extra cycles by being
> enclosed in parentheses?
> 
> Or is this just a coding style thing?

Just coding style. I agree you should have no parentheses there, but it
does not change the compiled code.

	Arnd
