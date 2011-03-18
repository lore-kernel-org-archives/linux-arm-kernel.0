From: b32955@freescale.com (Huang Shijie)
Date: Fri, 18 Mar 2011 10:06:04 +0800
Subject: [PATCH 1/7] ARM: add GPMI support for imx23/imx28
In-Reply-To: <19841.58406.756435.967812@ipc1.ka-ro>
References: <1300239773-4222-1-git-send-email-b32955@freescale.com>	<1300239773-4222-2-git-send-email-b32955@freescale.com>	<19840.36163.967469.53941@ipc1.ka-ro>	<4D809453.4090603@freescale.com>	<19840.43943.592336.854865@ipc1.ka-ro>	<4D816FA3.2080202@freescale.com>
	<19841.58406.756435.967812@ipc1.ka-ro>
Message-ID: <4D82BE0C.5050106@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi:

>>> IMO all the source code could be kept in one file (except for the
>>> include files of course) and the gpmi-nfc subdirectory removed.
>> I really can merge some files, but IMHO, it's not a good solution to
>> keep all in one file.
>>
>> The reasons are :
>> [1] The GPMI support the NAND boot mode,but the imx23 and imx28 is a
>> little different in
>> the NAND boot procedure due the different firmwares in the chips. If I
>> merge the rom-imx23.c
>> rom-imx28.c to one file, the code will very mess. ugly enough!
>>
> You can use platform_ids to differentiate between the versions and
> have separate functions for imx23 and imx28 where appropriate and
> select between those depending on the platform_id.
>
>
thanks a lot.


Best Regards.
Huang Shijie
