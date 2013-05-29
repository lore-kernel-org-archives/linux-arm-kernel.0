From: dt.tangr@gmail.com (Daniel Tang)
Date: Wed, 29 May 2013 15:18:03 +1000
Subject: [RFC PATCHv4 0/6] arm: Initial TI-Nspire support
In-Reply-To: <201305271231.40693.arnd@arndb.de>
References: <1369480087-24786-1-git-send-email-dt.tangr@gmail.com>
 <201305262323.29519.arnd@arndb.de>
 <30BA4666-664F-4DA4-A1D5-C2B8AA63C6AB@gmail.com>
 <201305271231.40693.arnd@arndb.de>
Message-ID: <146FF7AD-650E-4706-B9E1-53C2693D1D0D@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 27/05/2013, at 8:31 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday 27 May 2013, Daniel Tang wrote:
>>> The one remaining bit that sticks out is the clcd platform data. As I
>>> said before, I won't require you to convert that to DT in order to
>>> get your code merged, but I'd also really like to see that happen,
>>> as we will also need that to get rid of auxdata on the ARM reference
>>> platforms (integrator, versatile, realview, vexpress).
>> 
>> How would you like me to convert the platform data to DT? AFAIK, the clcd
>> driver isn't aware of DT so the only way is to use the AUXDATA right now.
> 
> Linus Walleij mentioned on IRC that Pawel Moll already posted a series
> that adds DT support for clcd:
> 
> http://lists.freedesktop.org/archives/dri-devel/2013-April/037519.html
> 
> The series does a few more things, but you can probbly split out the
> parts you need and base on that.

Would it be fine if I waited until CLCD DT patch gets into mainline instead?

> 
> 	Arnd

Cheers,
Daniel Tang
