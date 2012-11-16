From: narkewoody@gmail.com (Woody Wu)
Date: Fri, 16 Nov 2012 00:56:40 +0000 (UTC)
Subject: ttySAC0 or ttyS0 in 3.6.x ARM Linux?
References: <k824bb$7kp$1@ger.gmane.org>
 <20121115171615.GP3290@n2100.arm.linux.org.uk>
Message-ID: <slrnkab3r9.270.narkewoody@CNZUHNB705.adhoc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-15, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Thu, Nov 15, 2012 at 03:07:24PM +0800, woody wrote:
>> In the 3.6.6 ARM kernel, should I use ttySAC0 or ttyS0 to specify the  
>> 'console' kernel command line?
>
> That depends on what type of UART you're using.  ttyS is for 8250 ports.
> ttySAC ended up being used for various SoC based ports which aren't
> 8250 based.

Thanks. I think I understood.

The only strange thing is that, however, on my here this is a 2.6.16.4
kernel, that was using ttyS instead of ttySAC for the same physical port
on the same board.

-- 
-woody
I can't go back to yesterday - because I was a different person then.
