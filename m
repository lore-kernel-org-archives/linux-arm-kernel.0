From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 May 2013 13:28:17 +0100
Subject: [PATCH -v10 11/11] Move arch/x86 reboot= handling to generic
 kernel.
In-Reply-To: <1368273447-11958-12-git-send-email-holt@sgi.com>
References: <1368273447-11958-1-git-send-email-holt@sgi.com>
 <1368273447-11958-12-git-send-email-holt@sgi.com>
Message-ID: <20130511122817.GB18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 11, 2013 at 06:57:27AM -0500, Robin Holt wrote:
> Merge together the unicore32, arm, and x86 reboot= command line
> parameter handling.
> 
> Signed-off-by: Robin Holt <holt@sgi.com>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: Russ Anderson <rja@sgi.com>
> Cc: Robin Holt <holt@sgi.com>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Cc: the arch/x86 maintainers <x86@kernel.org>
> Cc: Arm Mailing List <linux-arm-kernel@lists.infradead.org>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
