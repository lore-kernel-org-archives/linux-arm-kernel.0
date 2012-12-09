From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 9 Dec 2012 10:51:17 +0400
Subject: Question2: Determine subarch type
Message-ID: <20121209105117.1f96e5c80560a8431a9eecee@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

How can we determine the sub-architecture type from the driver code?
For example, we are building a multi-platform kernel for subarch A and B.
One of the drivers should be used for subarch A only, and can not be used for
subarch B. So, we need to avoid load this driver for other sub-architectures.
Of course, we can check all machines in the subarch with machine_is_xx() macro,
but I think that this is not the best way to do it.
Do we have another way to do this?

-- 
Alexander Shiyan <shc_work@mail.ru>
