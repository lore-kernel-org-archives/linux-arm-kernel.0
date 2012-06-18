From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jun 2012 12:34:23 +0100
Subject: [RFC PATCH 4/8] ARM: smp: Move cpu initialization directly to
 ipi_cpu_stop
In-Reply-To: <1340019011-18642-5-git-send-email-monstr@monstr.eu>
References: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
 <1340019011-18642-5-git-send-email-monstr@monstr.eu>
Message-ID: <20120618113422.GD12029@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 01:30:07PM +0200, Michal Simek wrote:
> This is just preparation patch for dynamic IPI allocation.

Why?
