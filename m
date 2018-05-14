From: james.morse@arm.com (James Morse)
Date: Mon, 14 May 2018 16:12:42 +0100
Subject: [PATCH 4/4] firmware: arm_sdei: use common SMCCC_CONDUIT_*
In-Reply-To: <20180503170330.5591-5-mark.rutland@arm.com>
References: <20180503170330.5591-1-mark.rutland@arm.com>
 <20180503170330.5591-5-mark.rutland@arm.com>
Message-ID: <a8de1829-c7d8-d61a-b5b1-3fa4a36db67c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 03/05/18 18:03, Mark Rutland wrote:
> Now that we have common definitions for SMCCC conduits, move the SDEI
> code over to them, and remove the SDEI-specific definitions.
> 
> There should be no functional change as a result of this patch.

Thanks for clearing this up!

Acked-by: James Morse <james.morse@arm.com>


James
