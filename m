From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 10 Oct 2017 11:18:02 +0100
Subject: [PATCH 1/3] firmware: arm_scpi: remove default for get_scpi_ops
 if not reachable
In-Reply-To: <8afb173f-1480-baf8-e15b-5c01ed033671@gmail.com>
References: <8afb173f-1480-baf8-e15b-5c01ed033671@gmail.com>
Message-ID: <56633322-4a17-2af0-e86a-4e5bc8dd8557@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/10/17 19:49, Heiner Kallweit wrote:
> All callers of get_scpi_ops() depend on the result and therefore have
> a Kconfig dependency on ARM_SCPI_PROTOCOL. Means that ARM_SCPI_PROTOCOL
> being a module and caller being built-in can't occur.
> 

I just sent PR for v4.15 yesterday, so this needs to wait until v4.16. I
will take a look this before that.
-- 
Regards,
Sudeep
