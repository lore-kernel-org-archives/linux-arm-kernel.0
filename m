From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 28 Sep 2012 08:56:00 -0600
Subject: [PATCH] ARM: bcm2835: implement machine restart hook
In-Reply-To: <20120928121518.7f88196b@skate>
References: <1348805280-7647-1-git-send-email-swarren@wwwdotorg.org>
 <20120928121518.7f88196b@skate>
Message-ID: <5065BA80.1000001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2012 04:15 AM, Thomas Petazzoni wrote:
> Stephen,
> 
> On Thu, 27 Sep 2012 22:08:00 -0600, Stephen Warren wrote:
> 
>> +intc: interrupt-controller {
> 
> Isn't this a bizarre name for a watchdog device?

Yes, certainly! It looks like I only made this cut/paste mistake in the
binding document, which is why the code actually worked...

>> +	compatible = "brcm,bcm2835-pm-wdog";
>> +	reg = <0x7e100000 0x28>;
>> +};
