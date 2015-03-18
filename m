From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 18 Mar 2015 17:06:14 +0100
Subject: [PATCH 1/5] MFD/OF: document MFD devices and handle simple-mfd
In-Reply-To: <1425375148-4369-2-git-send-email-linus.walleij@linaro.org>
References: <1425375148-4369-1-git-send-email-linus.walleij@linaro.org>
 <1425375148-4369-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <20150318160614.GS4560@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2015 at 10:32:24 +0100, Linus Walleij wrote :
> This defines a new compatible option for MFD devices "simple-mfd" that will
> make the OF core spawn child devices for all subnodes of that MFD device.
> It is optional but handy for things like syscon and possibly other
> simpler MFD devices.
> 
> Since there was no file to put the documentation in, I took this opportunity
> to make a small writeup on MFD devices and add the compatible definition
> there.
> 
> Suggested-by: Lee Jones <lee.jones@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Devicetree <devicetree@vger.kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
