From: jonas.aberg@stericsson.com (Jonas Aaberg)
Date: Thu, 16 Sep 2010 11:29:34 +0200
Subject: [PATCH] ARM: New option for generating uncompressed uImage.
In-Reply-To: <20100916090439.GC20197@n2100.arm.linux.org.uk>
References: <1284621783-8196-1-git-send-email-jonas.aberg@stericsson.com>
	<20100916090439.GC20197@n2100.arm.linux.org.uk>
Message-ID: <4C91E37E.9000606@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2010 11:04 AM, Russell King - ARM Linux wrote:
> On Thu, Sep 16, 2010 at 09:23:03AM +0200, Jonas Aaberg wrote:
>> Some systems do boot faster with an uncompressed kernel.
> 
> Do this externally.  uImage in the kernel build is a pain in the
> backside because different people want different things from it.

Ok. I see your point. Maybe uImage generation should be removed 
from the kernel build system.

BR,
 Jonas
