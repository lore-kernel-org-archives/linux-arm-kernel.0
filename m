From: cavokz@gmail.com (Domenico Andreoli)
Date: Tue, 19 Apr 2011 12:59:47 +0200
Subject: Cleanup Samsung stuff
In-Reply-To: <BANLkTim2VJBoO-otakfVQaYsXLTyM91jsA@mail.gmail.com>
References: <012801cbfe33$a76fa490$f64eedb0$%kim@samsung.com>
	<20110419080307.GA26650@sirena.org.uk>
	<BANLkTim2VJBoO-otakfVQaYsXLTyM91jsA@mail.gmail.com>
Message-ID: <BANLkTikxV+4Zxf6Mh1se-h396G4m4qiwaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 10:40 AM, Thomas Abraham <thomas.ab@samsung.com> wrote:
> On Tue, Apr 19, 2011 at 1:33 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Tue, Apr 19, 2011 at 10:46:47AM +0900, Kukjin Kim wrote:
>>
>>> - Device tree (with Linaro)
>>
>> What is going on with device tree? ?I've asked a couple of times about
>> this in the other thread but I'm still not clear where the code is or
>> what could usefully be done with it.
>
> Currently I am working on supporting clkdev and Jeremy's common clock
> for all of Samsung's platforms and then continue with the device tree
> support for s5pv310.

I already posted some patches that add DeviceTree to s3c24xx (gpio, sdi).
I'm hanging on sdi because I found that mmc-spi already has some DT
support and I'm working to generalize it.

If nobody opposes I'll continue with the effort.

cheers,
Domenico

-----[ Domenico Andreoli, aka cavok
?--[ http://www.dandreoli.com/gpgkey.asc
?? ---[ 3A0F 2F80 F79C 678A 8936? 4FEE 0677 9033 A20E BC50
