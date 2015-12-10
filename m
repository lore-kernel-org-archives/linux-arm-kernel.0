From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Dec 2015 09:04:10 +0100
Subject: [PATCH v2 4/9] ARM: dts: add dts files for hi3519-demb board
In-Reply-To: <56691C65.6090808@huawei.com>
References: <1449110668-23647-1-git-send-email-xuejiancheng@huawei.com>
 <5533669.m0KDLq8XOc@wuerfel> <56691C65.6090808@huawei.com>
Message-ID: <2721289.3GUub5trUg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 December 2015 14:32:05 xuejiancheng wrote:
> > 
> > This is not what I meant. You have to use "syscon" as the most generic
> > "compatible" value here, but should add a machine specific string
> > as a more specific one. "hisilicon,sysctrl" is not appropriate because
> > it does not identify the IP block uniquely, you can only use that
> > in combination with another more specific string.
> 
> OK. I will use "hisilicon,hi3519-syscon" and "syscon" as the compatible value
> for the sysctrl node in hi3519.dtsi.
> 

Why hisilicon,hi3519-syscon instead of hisilicon,hi3519-sysctrl?

Is this not called a sysctrl at all in the datasheet then?

	Arnd
