From: b32955@freescale.com (Huang Shijie)
Date: Thu, 31 Mar 2011 18:12:43 +0800
Subject: [ PATCH V2  3/7] MTD : add the database for the NANDs
In-Reply-To: <1301565649.2828.33.camel@localhost>
References: <1301048581-21321-1-git-send-email-b32955@freescale.com>	<1301048581-21321-4-git-send-email-b32955@freescale.com>	<201103251134.44731.ffainelli@freebox.fr>	<4D8FEBC2.2030004@freescale.com>
	<1301565649.2828.33.camel@localhost>
Message-ID: <4D94539B.3050908@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:
> On Mon, 2011-03-28 at 10:00 +0800, Huang Shijie wrote:
>> These nands are only a example. I have other nands to add in future.
>> I will fix nand_get_flash_type() in future, not now. thanks
>>
>> Btw : I forget to add  the `busw` field in my nand_device_info{}.
> I think you should consider this as a merge criteria - I do not think we
> can allow people to have their own NAND data-bases, even "for now".
>
In the version 3, I want to replace the old database.


Thanks
Huang Shijie
