From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 12 Jul 2013 17:57:51 +0530
Subject: [PATCH] arm: omap2plus: unidle devices which are about to probe
In-Reply-To: <20130712121031.GB17053@arwen.pp.htv.fi>
References: <20130711092612.GG23892@arwen.pp.htv.fi>
 <1373537788-30413-1-git-send-email-balbi@ti.com> <51DFEF59.1010509@ti.com>
 <20130712121031.GB17053@arwen.pp.htv.fi>
Message-ID: <51DFF647.6030709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 July 2013 05:40 PM, Felipe Balbi wrote:
>> 3) I've checked most of OMAP drivers and all of them solve such kind
>> > of problem internally (SPI, MMC, I2C, etc.)
> and you see no problem with that ? Repeating the same thing over and
> over again ?
> 

I agree with Felipe that this is best handled at the bus/omap-device level
to avoid all drivers having to repeat the same thing over.
Having said that I dont know whats the best way to do this for OMAP and the
patch we have currently does seem to have atleast issues handling processor
IPs as Suman mentioned.

regards,
Rajendra
