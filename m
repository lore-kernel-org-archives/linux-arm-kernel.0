From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Fri, 29 Jun 2012 15:54:04 +0200
Subject: Current state of AM33xx patches
In-Reply-To: <4FEC7394.9030208@gmail.com>
References: <4FD5BA4C.9070706@gmail.com> <CBFB6F19.95320%jkridner@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA5361A@DBDE01.ent.ti.com>
 <4FE326A8.8090807@gmail.com> <4FE8AB37.7030907@gmail.com>
 <4FE9A00B.6010908@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA5B7FD@DBDE01.ent.ti.com>
 <4FEC7394.9030208@gmail.com>
Message-ID: <4FEDB37C.4070604@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.06.2012 17:09, schrieb Daniel Mack:
> On 27.06.2012 14:13, Hiremath, Vaibhav wrote:
> 
>> Just to clarify from AM335x perspective,
>>
>> In case of AM335x, since the patches and complete BasePort support is still
>> not present in the Mainline (neither in Linus's tree not in linux-omap), you 
>> need to use my Repo (https://github.com/hvaibhav: Closely follows linux-
>> omap/master) in order to test something on BeagleBone platform.
> 
> Great, that is the information I've been looking for.
> 
> Your am335x-upstream-staging branch works for me on a custom AM335x
> based board using a custom DT config.
> 
> I'll dig through the sources and come back once I know which parts are
> missing.

Do you have LCD screen attached? I need a functioning framebuffer driver. So far if I start x-server I get various errors:

(EE) FBDEV(0): internal error: miCreateDefColormap failed in FBDevScreenInit()

and before this error there was FB_BLANK_NORMAL option missing in drivers/video/da8xx-fb.c. That's why I think that the current driver is not really production ready.

Best regards,
Yegor
