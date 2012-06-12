From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 12 Jun 2012 15:01:23 +0200
Subject: [PATCH v2 3/8] arm: mach-mvebu: add compilation/configuration
 change
In-Reply-To: <201206120839.02915.arnd@arndb.de>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <1339433585-28087-4-git-send-email-gregory.clement@free-electrons.com>
 <201206120839.02915.arnd@arndb.de>
Message-ID: <4FD73DA3.2060505@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2012 10:39 AM, Arnd Bergmann wrote:
> On Monday 11 June 2012, Gregory CLEMENT wrote:
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Signed-off-by: Lior Amsalem <alior@marvell.com>
> 
> Please always keep this patch last in the series, as soon as it is applied,
> one can build a kernel for mvebu, which ends up not working. Each step
> in a patch series needs to provide a working, incremental improvement
> over the previous one, so when adding a new feature in parts, you can
> only enable it once you have something that actually builds.
> 

Ok I will move this patch at the end of the serie for the next version.


> 	Arnd
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
+33 602 196 044
