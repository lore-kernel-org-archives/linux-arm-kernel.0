From: FlorianSchandinat@gmx.de (Florian Tobias Schandinat)
Date: Sun, 19 Feb 2012 22:40:05 +0000
Subject: [PATCH 00/13] sa1100fb cleanups
In-Reply-To: <20120204093744.GQ889@n2100.arm.linux.org.uk>
References: <20120204093744.GQ889@n2100.arm.linux.org.uk>
Message-ID: <4F417A45.8040106@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 02/04/2012 09:37 AM, Russell King - ARM Linux wrote:
> Here's another bunch of SA11x0 stuff - its framebuffer driver.  This
> set of patches fixes some section mismatch warnings, moves the board
> configuration out to the board files, converts the Shannon stuff to
> use gpiolib rather than poking at GPDR/GPSR/GPCR directly.
> 
> The function hooks for LCD and backlight power control are moved into
> the platform data passed from the board, eliminating the global function
> pointers.

This series looks good to me.
Acked-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

> This series will conflict with the previous series (in the case of
> Assabet, the conflict is quite large) so I'd prefer to keep this in my
> tree for the next merge window.

Sure, feel free to proceed with this series as you like.


Best regards,

Florian Tobias Schandinat
