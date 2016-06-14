From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Jun 2016 12:07:53 +0100
Subject: [PATCH 4/5] arm64: hibernate: Identify the CPU to resume on by
 its MPIDR
In-Reply-To: <1464876657-6692-5-git-send-email-james.morse@arm.com>
References: <1464876657-6692-1-git-send-email-james.morse@arm.com>
 <1464876657-6692-5-git-send-email-james.morse@arm.com>
Message-ID: <20160614110752.GC19235@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 03:10:56PM +0100, James Morse wrote:
> +		pr_info("Suspended on a CPU that is offline! Brining CPU up.\n");

Nit: typo, should be "Bringing".

Otherwise the patch looks good!

Thanks,
Mark.
