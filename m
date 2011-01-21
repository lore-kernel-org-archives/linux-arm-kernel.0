From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jan 2011 11:13:55 +0000
Subject: [PATCH] ARM: aaec2000: remove support for mach-aaec2000
In-Reply-To: <1294430422-939-1-git-send-email-jamie@jamieiles.com>
References: <1294430422-939-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20110121111355.GN13235@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 07, 2011 at 08:00:22PM +0000, Jamie Iles wrote:
> mach-aaec2000 is no longer actively maintained and is only receiving
> fixups to remain building with other kernel updates.
> 
> Cc: Bellido Nicolas <ml@acolin.be>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>

Okay, could you send the two patches to the patch system and I'll add it
to a 'remove' branch (which now has lh7a40x in as well) for 2.6.39.

Thanks.
