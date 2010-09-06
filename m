From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Mon, 6 Sep 2010 21:42:41 +0200
Subject: [PATCH v5 3/7] wireless: wl12xx: add platform data passing support
In-Reply-To: <20100906120716.GE20903@n2100.arm.linux.org.uk>
References: <1283376410-9999-1-git-send-email-ohad@wizery.com>
	<1283376410-9999-4-git-send-email-ohad@wizery.com>
	<AANLkTi=goLEUqM1XQ__PrGu4=Erw2utaNP4qFmSgRta2@mail.gmail.com>
	<20100906120716.GE20903@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikAFCd+3ggZKhQXY=+bG==KgLkv3qNVdEGa=GBX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 6 wrze?nia 2010 14:07 u?ytkownik Russell King - ARM Linux
<linux@arm.linux.org.uk> napisa?:
> On Sat, Sep 04, 2010 at 02:23:19PM +0200, Micha? Miros?aw wrote:
>> 2010/9/1 Ohad Ben-Cohen <ohad@wizery.com>:
>> > Add a simple mechanism to pass platform data to the
>> > SDIO instances of wl12xx.
[cut patch]
>> Why do you need all that copying? Isn't the data constant?
>
> The first copy is to allow platforms to have their data marked with
> __initdata. ?The second copy probably isn't necessary, but avoids
> problems where the driver may decide to modify the platform data.

Sorry for pushing at this, but why would you mark data that's meant to
be used after init phase as __initdata?

Best Regards,
Micha? Miros?aw
