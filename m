From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 Oct 2009 17:55:10 +0100
Subject: [PATCH 1/1] reboot: Fix Realview ARM1176PB board reboot
In-Reply-To: <1256216280.6515.13.camel@localhost.localdomain>
References: <1256216280.6515.13.camel@localhost.localdomain>
Message-ID: <1256230510.8608.50.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-10-22 at 18:28 +0530, Philby John wrote:
> Ping on this one! Is there anything else that I must do here other
> than the void* type cast that Russell asked me to correct?

It seems to be ok but I haven't had time to try it on hardware. Assuming
that you did the testing:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

-- 
Catalin
