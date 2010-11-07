From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 7 Nov 2010 17:23:10 +0000
Subject: [patch v3 2/2] ARM: mach-shmobile: Add zboot support for
	SuperH Mobile ARM
In-Reply-To: <20101014091434.501864612@vergenet.net>
References: <20101014091231.858799238@vergenet.net>
	<20101014091434.501864612@vergenet.net>
Message-ID: <20101107172310.GG1759@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 14, 2010 at 06:12:33PM +0900, Simon Horman wrote:
> +LIST "partner-jet-setup.txt"
> +LIST "(C) Copyright 2010 Renesas Solutions Corp"
> +LIST "Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>"
> +
> +LIST "RWT Setting"
> +EW 0xE6020004, 0xA500
> +EW 0xE6030004, 0xA500

Can you explain the necessity of this special scripting language, and
where it comes from?

It looks like the file implementing the scripting language comes from
something other than Linux, but it isn't clear what the licensing is
of that.  Please confirm that it is GPL'd.
