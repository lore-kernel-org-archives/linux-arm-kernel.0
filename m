From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Apr 2010 21:03:26 +0100
Subject: [RFC 05/10] arm: kdump: make kexec work in interrupt context
In-Reply-To: <f05417b66eedd3c1fe32b433dcdae71a2a151da5.1269854500.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<f05417b66eedd3c1fe32b433dcdae71a2a151da5.1269854500.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <20100412200326.GV3048@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 29, 2010 at 12:26:31PM +0300, Mika Westerberg wrote:
> When crash happens in interrupt context there is no userspace context. We always
> use current->active_mm in those cases.

Ok.  This should probably be a standalone bug fix.  Please send it
to the patch system, thanks.
