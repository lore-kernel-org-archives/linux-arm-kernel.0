From: B37400@freescale.com (Singh Sandeep-B37400)
Date: Mon, 30 Jul 2012 09:50:57 +0000
Subject: [2/3][PATCH][v2] TDM Framework
In-Reply-To: <20120727152542.GB1613@electric-eye.fr.zoreil.com>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20120727152542.GB1613@electric-eye.fr.zoreil.com>
Message-ID: <3F1D9DCAAB49B94D88DBE05911FA4E6E511121@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your comments. Please find replies inline.

Regards,
Sandeep

-----Original Message-----
From: Francois Romieu [mailto:romieu at fr.zoreil.com] 
Sent: 27 July 2012 20:56
To: Singh Sandeep-B37400
Cc: linuxppc-dev at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org; galak at kernel.crashing.org; linux-kernel at vger.kernel.org; devel at driverdev.osuosl.org
Subject: Re: [2/3][PATCH][v2] TDM Framework

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
[Sandeep] We do have a test client but not good enough to be pushed in open source, should we add it to documentation?? 

2. It would probably make sense to Cc: netdev and serial. There may be
   some kernel client network integration from the start.
[Sandeep] Ok. 

3. Where is the userspace configuration interface ?
[Sandeep] TDM framework right now supports only kernel mode clients. It has been tested with the client module that I mentioned above. Both the framework and test client are a part of Freescale BSP.

[...]
> Based on: git://git.am.freescale.net/gitolite/mirrors/galak-powerpc.git
[Sandeep] Please try below mentioned link. The above one is Freescale's internal mirror of:
git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git 

$ git clone git://git.am.freescale.net/gitolite/mirrors/galak-powerpc.git
Cloning into 'galak-powerpc'...
fatal: Unable to look up git.am.freescale.net (port 9418) (No address associated with hostname)

-- 
Ueimor
