From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Apr 2011 17:25:12 +0100
Subject: [PATCH 33/34] usb/lh7a40x_udc: Drop __DATE__ usage
In-Reply-To: <1302015561-21047-34-git-send-email-mmarek@suse.cz>
References: <1302015561-21047-1-git-send-email-mmarek@suse.cz>
	<1302015561-21047-34-git-send-email-mmarek@suse.cz>
Message-ID: <20110405162512.GB11737@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2011 at 04:59:20PM +0200, Michal Marek wrote:
> The kernel already prints its build timestamp during boot, no need to
> repeat it in random drivers and produce different object files each
> time.

This file no longer exists.
