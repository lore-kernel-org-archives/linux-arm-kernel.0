From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Jun 2013 12:58:10 +0200
Subject: [PATCH -v11 resend 10/11] arm,
 change reboot_mode to use enum reboot_mode
In-Reply-To: <1370519244-49918-11-git-send-email-holt@sgi.com>
References: <1370519244-49918-1-git-send-email-holt@sgi.com>
 <1370519244-49918-11-git-send-email-holt@sgi.com>
Message-ID: <4169120.1k31YLDD12@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 June 2013 06:47:23 Robin Holt wrote:
> Preparing to move the parsing of reboot= to generic kernel code
> forces the change in reboot_mode handling to use the enum.
> 
> Signed-off-by: Robin Holt <holt@sgi.com>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Russ Anderson <rja@sgi.com>
> Cc: Robin Holt <holt@sgi.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Cc: the arch/x86 maintainers <x86@kernel.org>
> Cc: Arm Mailing List <linux-arm-kernel@lists.infradead.org>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Should we merge this through the arm-soc tree?

I'm getting a few conflicts with new platforms getting added
using the old interface.

	Arnd
