From: shinya.kuribayashi@necel.com (Shinya Kuribayashi)
Date: Tue, 13 Oct 2009 17:01:28 +0900
Subject: [RFC] i2c-designware patches
In-Reply-To: <20091013070412.GA9739@jasper.tkos.co.il>
References: <4AD3E974.8080200@necel.com>
	<20091013070412.GA9739@jasper.tkos.co.il>
Message-ID: <4AD433D8.8090900@necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Baruch Siach wrote:
> On Tue, Oct 13, 2009 at 11:44:04AM +0900, Shinya Kuribayashi wrote:
>> Here're various improvements / bug-fixing patches for DW I2C driver.
>> I'm working with v2.6.27-based kernel, but they must work fine with the
>> latest mainline kernel.
>>
>> It's stil in RFC, and I'm working with it for some time.  Any comments
>> or suggestions are highly appreciated.  Then I'll respin and give it a
>> test, thanks.
>>
>> Baruch, I'd say the base driver is in good shape enogh, so I'm having
>> a fun with modifing the driver.  Thanks for the initial work.
> 
> Thanks. It is good to see that my work is actually useful for someone. I'll go 
> over this series in the coming days. Unfortunately I don't have the hardware 
> for testing anymore, but I'll try at least to compile test these patches.

No problem, I could do real tests on real hardwares, so just give me a
feedback.  Grammar corrections or rewording is also appriciated.

> By the way, what is the chip you work with?

I'd like to avoid specific comment on this.  I'm working with our big-
endian MIPS SoCs which are not in mainline.

-- 
Shinya Kuribayashi
NEC Electronics
