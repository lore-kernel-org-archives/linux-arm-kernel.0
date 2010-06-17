From: jason77.wang@gmail.com (jason)
Date: Thu, 17 Jun 2010 21:37:50 +0800
Subject: [PATCH 1/2] mxc: add common debug board for 3-stack platforms
In-Reply-To: <20100616065540.GI20799@pengutronix.de>
References: <1276352707-8199-1-git-send-email-jason77.wang@gmail.com>
	<1276352707-8199-2-git-send-email-jason77.wang@gmail.com>
	<20100616065540.GI20799@pengutronix.de>
Message-ID: <4C1A252E.8090101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer wrote:
> On Sat, Jun 12, 2010 at 10:25:06PM +0800, Jason Wang wrote:
>   
>> The debug board is little different for all mxc 3-stack(PDK)
>> platforms, it is possible here to add a common implementation to
>> support this board.
>>     
>
> Two small things left:
>
> Could you change the name cpld_debugboard.c to something like
> 3ds_debugboard.c? That we are talking about the 3ds is much more
> interesting than that there's a cpld on the board.
>
> Also, I really prefer having no extra header file for the debug board.
> All information in this header file is only interesting in this single C
> file.
>
> Sascha
>
>
>   
Accept, will fix in next version.

Thanks,
Jason.
>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>> ---
>>  arch/arm/plat-mxc/Kconfig                        |   11 ++
>>  arch/arm/plat-mxc/Makefile                       |    1 +
>>  arch/arm/plat-mxc/cpld_debugboard.c              |  161 ++++++++++++++++++++++
>>  arch/arm/plat-mxc/include/mach/cpld_debugboard.h |   60 ++++++++
>>  4 files changed, 233 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/plat-mxc/cpld_debugboard.c
>>  create mode 100644 arch/arm/plat-mxc/include/mach/cpld_debugboard.h
>>     
<snip>
