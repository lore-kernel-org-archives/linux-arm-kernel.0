From: romieu@fr.zoreil.com (Francois Romieu)
Date: Fri, 27 Jul 2012 17:25:42 +0200
Subject: [2/3][PATCH][v2] TDM Framework
In-Reply-To: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
Message-ID: <20120727152542.GB1613@electric-eye.fr.zoreil.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sandeep at freescale.com <sandeep@freescale.com> :
[...]
> The main functions of this Framework are:
>  - provides interface to TDM clients to access TDM functionalities.
>  - provides standard interface for TDM drivers to hook with the framework.
>  - handles various data handling stuff and buffer management.
> 
> In future this Framework will be extended to provide Interface for Line control devices also. For example SLIC, E1/T1 Framers etc.
> 
> Presently the framework supports only Single Port channelised mode.
> Also the configurability options are limited which will be extended later on.
> Only kernel mode TDM clients are supported currently. Support for User mode clients will be added later.

1. You should send some kernel mode TDM clients. Without those the framework
   is pretty useless.

2. It would probably make sense to Cc: netdev and serial. There may be
   some kernel client network integration from the start.

3. Where is the userspace configuration interface ?

[...]
> Based on: git://git.am.freescale.net/gitolite/mirrors/galak-powerpc.git

$ git clone git://git.am.freescale.net/gitolite/mirrors/galak-powerpc.git
Cloning into 'galak-powerpc'...
fatal: Unable to look up git.am.freescale.net (port 9418) (No address associated with hostname)

-- 
Ueimor
