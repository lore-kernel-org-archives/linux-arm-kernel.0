From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jun 2012 12:36:17 +0100
Subject: [RFC PATCH 6/8] ARM: smp: Use generic API for ipi
In-Reply-To: <1340019011-18642-7-git-send-email-monstr@monstr.eu>
References: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
 <1340019011-18642-7-git-send-email-monstr@monstr.eu>
Message-ID: <20120618113617.GF12029@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 01:30:09PM +0200, Michal Simek wrote:
> Support dynamic IPI allocation. It supports cases
> where user wants to use IPI for communication among cpus
> and setup own handler for it.
> 
> New functions set_ipi_handler/clear_ipi_handler are used
> for dynamic allocation.

For what purpose?
