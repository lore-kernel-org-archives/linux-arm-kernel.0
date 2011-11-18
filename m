From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Fri, 18 Nov 2011 08:51:58 +0100
Subject: [PATCH 6/7] ARM: restart: only perform setup for restart when
 soft-restarting
In-Reply-To: <20111117174247.GF9581@n2100.arm.linux.org.uk> (Russell King's
 message of "Thu, 17 Nov 2011 17:42:47 +0000")
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6b9-0001NG-NS@rmk-PC.arm.linux.org.uk>
 <20111117174247.GF9581@n2100.arm.linux.org.uk>
Message-ID: <m3y5vdrhpd.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

>> We only need to set the system up for a soft-restart if we're going to
>> be doing a soft-restart.  Provide a new function (soft_restart()) which
>> does the setup and final call for this, and make platforms use it.
>> Eliminate the call to setup_restart() from the default handler.

>>  arch/arm/mach-ixp4xx/include/mach/system.h        |    2 +-

Acked-by: Krzysztof Ha?asa <khc@pm.waw.pl>
-- 
Krzysztof Halasa
