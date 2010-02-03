From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Feb 2010 10:08:13 +0000
Subject: [PATCH 02/16] ARM: LPC32XX: removed extra include statement
In-Reply-To: <1265155168-28909-3-git-send-email-wellsk40@gmail.com>
References: <1265155168-28909-3-git-send-email-wellsk40@gmail.com>
Message-ID: <20100203100813.GB22275@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2010 at 03:59:14PM -0800, wellsk40 at gmail.com wrote:
> From: Kevin Wells <wellsk40@gmail.com>
> 
> The include of <mach/irqs.h> isn't needed in the entry-macro.S
> file.

Ditto.
