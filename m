From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sat, 9 Apr 2011 01:46:29 +0200
Subject: [RFC][WAS:bcmai][PATCH V2] axi: add AXI bus driver
In-Reply-To: <20110408220157.GC26019@kroah.com>
References: <1302291900-1902-1-git-send-email-zajec5@gmail.com>
	<20110408220157.GC26019@kroah.com>
Message-ID: <BANLkTin_-hhcexTd67HviTqM4bjXMZxweA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/9 Greg KH <greg@kroah.com>:
>> +static void axi_release_core_dev(struct device *dev)
>> +{
>> + ? ? kfree(dev);
>> +}
>
> This is wrong, unless you are really only creating a 'struct device'.
> Why are you doing that instead of embedding struct device in your
> structure?

Hm, I think Greg found explanation why we can not reload axi driver
successfully :)

I'll take care of your comment after weekend, thank you everybody.

-- 
Rafa?
