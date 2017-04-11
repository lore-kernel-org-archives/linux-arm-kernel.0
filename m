From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 11 Apr 2017 22:25:00 +0200
Subject: at91: serial: Can't use DMA on 4.x kernels in RS-485 mode on
 at91sam9x5
In-Reply-To: <DM5PR05MB295463261205406FFF273D3BBB000@DM5PR05MB2954.namprd05.prod.outlook.com>
References: <DM5PR05MB2954D56C2E266AF16B250ACCBB0B0@DM5PR05MB2954.namprd05.prod.outlook.com>
 <20170404203249.GA4416@gradator.net>
 <DM5PR05MB295425DD88B5A8ADF88B81F8BB0B0@DM5PR05MB2954.namprd05.prod.outlook.com>
 <DM5PR05MB29548291A13C348889156EDDBB0C0@DM5PR05MB2954.namprd05.prod.outlook.com>
 <DM5PR05MB2954F35F2EBB9EEE987F3401BB000@DM5PR05MB2954.namprd05.prod.outlook.com>
 <20170411185924.6g4cgk4h6ogsmyd5@piout.net>
 <DM5PR05MB295463261205406FFF273D3BBB000@DM5PR05MB2954.namprd05.prod.outlook.com>
Message-ID: <20170411202500.xmi6qlbtqhrboedt@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2017 at 20:13:19 +0000, Bryan Evenson wrote:
> I checked the various branches on the linux-stable repository, and I see this commit in master and on 4.9, but I don't see it in any branches prior to that one.  Since this issue was introduced back in 4.1, I think this patch would be suitable for backporting to the 4.1 and 4.4 stable branches.  Is there something I can do to help make that happen?
> 

Indeed, the Fixes: tag doesn't have the usual format, that would explain
why.

I'll resend to stable

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
