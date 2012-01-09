From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Jan 2012 11:29:20 +0000
Subject: [PATCH 1/2] at91 : move pm.h header to arch/arm/include/asm
In-Reply-To: <4F0ACD35.1000600@linaro.org>
References: <1325864915-794-1-git-send-email-daniel.lezcano@linaro.org>
 <201201061730.33525.arnd.bergmann@linaro.org> <4F0ACD35.1000600@linaro.org>
Message-ID: <20120109112920.GJ21765@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 12:19:17PM +0100, Daniel Lezcano wrote:
> Actually, the header moves from :
> 
> 	arch/arm/mach-at91/pm.h
> to:
> 	arch/arm/include/asm/at91_pm.h.
> 
> This place and the renaming of the file complies with the comments of
> Russell,

No it doesn't.  There's absolutely no way in hell I want arch/arm/include/asm
to be littered with hundreds of crappy platform specific header files.
