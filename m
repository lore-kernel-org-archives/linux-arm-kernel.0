From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Nov 2009 19:32:44 +0000
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <200911041433.32010.jpihet@mvista.com>
References: <1256123277.3851.36.camel@debian-nb>
	<200910281723.01684.jpihet@mvista.com>
	<200910281800.47681.jpihet@mvista.com>
	<200911041433.32010.jpihet@mvista.com>
Message-ID: <20091104193244.GC518@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2009 at 02:33:31PM +0100, Jean Pihet wrote:
> Is this one OK? Can it be merged now that your fix for signal restart
> has been merged into mainline?

Yes.
