From: davem@davemloft.net (David Miller)
Date: Wed, 02 Dec 2015 15:56:15 -0500 (EST)
Subject: [PATCH v2 4/5] net: thunderx: Switchon carrier only upon
 interface link up
In-Reply-To: <011f01d12cf4$de8bc7c0$9ba35740$@samsung.com>
References: <1449050777-37836-5-git-send-email-sunil.kovvuri@gmail.com>
 <00ec01d12cee$26a28a00$73e79e00$@samsung.com>
 <011f01d12cf4$de8bc7c0$9ba35740$@samsung.com>
Message-ID: <20151202.155615.518630269762334670.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pavel Fedin <p.fedin@samsung.com>
Date: Wed, 02 Dec 2015 14:30:37 +0300

>  Hello again!
> 
>> Subject: RE: [PATCH v2 4/5] net: thunderx: Switchon carrier only upon interface link up
>> 
>>  Just a reminder, we have issue with this one too, which is not addressed yet.
> 
>  I have examined the problem thoroughly and discovered that it is a problem with experimental BGX driver patches on my 4.2 host
> kernel build. It fails to send NIC_MBOX_MSG_BGX_LINK_CHANGE, so nothing works.
>  I have retested this series on top of 4.3 running on ThunderX. It has good BGX driver and everything works fine. Therefore, the
> whole series can be safely applied and...
> 
>  Tested-by: Pavel Fedin <p.fedin@samsung.com>

Ok, thanks for confirming things are fine now.

I'll apply this series.
