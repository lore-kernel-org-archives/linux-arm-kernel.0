From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 May 2013 13:29:40 +0100
Subject: [PATCH -v10 00/11] Shutdown from reboot_cpuid without stopping
 other cpus.
In-Reply-To: <1368273447-11958-1-git-send-email-holt@sgi.com>
References: <1368273447-11958-1-git-send-email-holt@sgi.com>
Message-ID: <20130511122939.GC18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 11, 2013 at 06:57:16AM -0500, Robin Holt wrote:
> We recently noticed that reboot of a 1024 cpu machine takes approx 16
> minutes of just stopping the cpus.  The slowdown was tracked to commit
> f96972f.
...
> Cc: Russell King <linux@arm.linux.org.uk>

Looks good now.  Acks supplied for relevant patches to ARM.  For the
remainder which will still have a Cc: line like the above, please
change it to use rmk+kernel at arm.linux.org.uk

Thanks.
