From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 May 2013 13:27:40 +0100
Subject: [PATCH -v10 08/11] arm, Remove unused restart_mode fields from
 some arm subarchs
In-Reply-To: <1368273447-11958-9-git-send-email-holt@sgi.com>
References: <1368273447-11958-1-git-send-email-holt@sgi.com>
 <1368273447-11958-9-git-send-email-holt@sgi.com>
Message-ID: <20130511122740.GA18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 11, 2013 at 06:57:24AM -0500, Robin Holt wrote:
> These restart_mode fields are not used at all.  Remove them to make
> moving the reboot= cmdline options to the general kernel easier.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
