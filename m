From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 11 Nov 2010 14:56:24 +0800
Subject: [Questions] How to run 'perf top' on ARM to profile kernel functions
	with modules loaded
Message-ID: <AANLkTinwAL8dFsDbd-ZTQEcEziq6jZk82KPzNqMVxnOx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

'perf top' can't display any functions when modules are loaded on ARM.

But if all modules are unloaded, everything is OK and kernel functions can be
displayed.

So how can I make 'perf top' to profile kernel functions when modules are loaded
on ARM?

thanks,
-- 
Lei Ming
