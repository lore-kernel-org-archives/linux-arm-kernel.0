From: bn@niasdigital.com (Ben Nizette)
Date: Sat, 23 Apr 2011 18:35:34 +1000
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <BANLkTikDCmH-WX1u3e9c7gc2U9HJ88RBUQ@mail.gmail.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTinrtoGhL3CXJZGWzf8+BwFSRsdk0w@mail.gmail.com>
	<BANLkTikDCmH-WX1u3e9c7gc2U9HJ88RBUQ@mail.gmail.com>
Message-ID: <4083C8C3-920B-4CE1-B393-D8BA0E7BFB13@niasdigital.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 22/04/2011, at 9:36 PM, Linus Walleij wrote:

> 2011/4/21 Stijn Devriendt <highguy@gmail.com>:
> 
> 
>> I'd also like to add (if not already mentioned by others) that in
>> general drivers that use GPIOs are unaware of their physical
>> connection on the board. Having this information
>> in device-tree or platform-data equivalent solves this.
> 
> Yes, this has been mentioned a few times, and a few times I have
> replied that there is not one word in the patch set that says anything
> about whether drivers or board code or whatever shall make use of
> the mechanism, it's just an interface...
> 
> I don't understand why this keeps popping up, have I written
> *anything* unclear about this?

You haven't, no!  Just that the use case for gpiolib was always to expose
gpio functionality to drivers/ in a generic way.  The fact that it's
now been picked up extensively throughout arch/ is a (very) happy
side-effect.

	--Ben.
