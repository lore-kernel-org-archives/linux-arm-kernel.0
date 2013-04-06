From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 6 Apr 2013 13:51:00 +0200
Subject: [RFC PATCH arm: initial TI-Nspire support]
In-Reply-To: <8FB21B56-58BC-4530-8C7A-71A32856210D@gmail.com>
References: <6FE4B33E-A503-4A75-AEED-831CB2C06D83@gmail.com>
 <201304041112.25780.arnd@arndb.de>
 <8FB21B56-58BC-4530-8C7A-71A32856210D@gmail.com>
Message-ID: <201304061351.00889.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 06 April 2013, Daniel Tang wrote:
> Hi,
> 
> First of all, thank you for your comments!
> 
> On 04/04/2013, at 10:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > For new platforms, we want to have only the absolute minimum amount of
> > code in arch/arm and move everything else into drivers. However, that
> > is only possible using device tree. It should not add any significant
> > complexity to your code, and you can easily bundle the device tree blob
> > with the kernel.
> 
> Given that most of your comments described some very fundamental changes
> (esp switching to DTB) to the structure of our port, we've decided we'll
> probably start from scratch and fix the issues you outlined as we
> reimplement our platform.
> 
> At the moment, we're working on getting a basic DTB-booting kernel working
> so our next patch will be starting from basics.

Ok, whichever way you prefer. If you have questions while working on this,
feel free to join #armlinux on irc.freenode.net, there are usually other
people working on the same things.

	Arnd
