From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 May 2016 10:12:29 +0100
Subject: [PATCH v6 07/14] arm64, numa: Cleanup NUMA disabled messages.
In-Reply-To: <1461780436-27182-8-git-send-email-ddaney.cavm@gmail.com>
References: <1461780436-27182-1-git-send-email-ddaney.cavm@gmail.com>
 <1461780436-27182-8-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160511091229.GB3051@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 11:07:09AM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> As noted by Dennis Chen, we don't want to print "No NUMA configuration
> found" if NUMA was forced off from the command line.
> 
> Change the type of numa_off to bool, and clean up printing code.
> Print "NUMA disabled" if forced off on command line and "No NUMA
> configuration found" if there was no firmware NUMA information.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
