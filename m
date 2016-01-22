From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jan 2016 13:55:34 +0000
Subject: [PATCH] ARM: add copy_file_range system call
In-Reply-To: <6994292.VtUkPlizQj@wuerfel>
References: <6994292.VtUkPlizQj@wuerfel>
Message-ID: <20160122135534.GC19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2016 at 02:47:36PM +0100, Arnd Bergmann wrote:
> The copy_file_range system call was added in linux-4.5 needs to
> be added to the system call tables on all architectures.
> 
> This is the change for arch/arm.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, but as ever I much prefer to update the syscall table myself
after -rc1.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
