From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 May 2013 11:06:16 +0200
Subject: [PATCH 00/19] driver:usb&net: add missing platform_driver owner
In-Reply-To: <519B2993.4090409@cn.fujitsu.com>
References: <1369104120-35552-1-git-send-email-libo.chen@huawei.com>
 <20130520.232619.964940909999914694.davem@davemloft.net>
 <20130521084108.1a585f32@skate> <519B2993.4090409@cn.fujitsu.com>
Message-ID: <20130521110616.21eee053@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gu Zheng,

On Tue, 21 May 2013 16:00:19 +0800, Gu Zheng wrote:

> > Or, maybe make the existing module_platform_driver() macro do this?
> 
> But not all the modules use module_platform_driver() macro to replace the module init/exit.

Then maybe it's a good opportunity to convert those ones to use
module_platform_driver() ?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
