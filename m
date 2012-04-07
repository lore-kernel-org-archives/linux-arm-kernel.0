From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 07 Apr 2012 21:46:25 +0400
Subject: [PATCH] ARM: orion5x: Fix GPIO enable bits for MPP9
In-Reply-To: <1333771725.7150.32.camel@deadeye>
References: <1333771725.7150.32.camel@deadeye>
Message-ID: <4F807D71.1090209@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07-04-2012 8:08, Ben Hutchings wrote:

> Commit 554cdaefd1cf7bb54b209c4e68c7cec87ce442a9 seems to have

    Please also specify that commit's summary in parens.

> accidentally inverted the GPIO valid bits for MPP9 (only).  For the
> mv2120 platform which uses MPP9 as a GPIO LED device, this results in
> the error:

> [   12.711476] leds-gpio: probe of leds-gpio failed with error -22

> Reported-by: Henry von Tresckow<hvontres@gmail.com>
> References: http://bugs.debian.org/667446
> Signed-off-by: Ben Hutchings<ben@decadent.org.uk>
> Cc: stable at vger.kernel.org [v3.0+]

WBR, Sergei
