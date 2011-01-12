From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Jan 2011 09:19:55 +0000
Subject: [PATCH v2] ARM: Change misleading warning when
	CONFIG_CMDLINE_FORCE is used
In-Reply-To: <1294789556-3870-1-git-send-email-holler@ahsoftware.de>
References: <1294789556-3870-1-git-send-email-holler@ahsoftware.de>
Message-ID: <20110112091955.GV11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 12:45:56AM +0100, Alexander Holler wrote:
> When CONFIG_CMDLINE_FORCE is used, the warning
> 
>   Ignoring unrecognised tag 0x54410009
> 
> was displayed. Change this to
> 
>   Ignoring tag cmdline (using the default kernel command line)

Patch is fine, can you send it to the patch system please?

Thanks.
