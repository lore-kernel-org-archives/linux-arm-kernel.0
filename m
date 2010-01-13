From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 13 Jan 2010 14:08:03 -0500
Subject: Question: __ARM_EABI__
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190902089C63@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

The following commit added a check for __ARM_EABI__ and raises a
warning if it's not defined.

commit 6603a4fd5195a004dec5f9568e38ff76bae630c1
Author: Claudio Scordino <claudio@evidence.eu.com>
Date:   Fri Oct 30 12:06:05 2009 +0100

    ARM: 5776/1: Check compiler version and EABI support when adding ARM unwind support.

Where is this definition supposed to come from?

I am using an EABI compiler but the warning still shows up.

Thanks,
Hartley
