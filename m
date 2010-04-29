From: mboards@prograde.net (Michael Cashwell)
Date: Thu, 29 Apr 2010 13:29:25 -0400
Subject: Decompression failure in an inexplicable case
In-Reply-To: <20100429163939.GF4877@n2100.arm.linux.org.uk>
References: <A809F2C8-74CA-474E-92B0-08A5227B7C3F@prograde.net>
	<1272558886.15152.4.camel@e102109-lin.cambridge.arm.com>
	<20100429163939.GF4877@n2100.arm.linux.org.uk>
Message-ID: <60A99E43-417D-426A-8308-0513473D99C5@prograde.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Apr 29, 2010, at 12:39 PM, Russell King - ARM Linux wrote:

> On Thu, Apr 29, 2010 at 05:34:46PM +0100, Catalin Marinas wrote:
>> On Thu, 2010-04-29 at 16:27 +0100, Michael Cashwell wrote:
>>> If I omit CPUFreq support [CONFIG_CPU_FREQ is not set], or enable both
>>> it and its debugging support [CONFIG_CPU_FREQ_DEBUG=y], the kernel
>>> builds and runs seemingly fine.
>>> 
>>> But if I have CONFIG_CPU_FREQ enabled but NOT its debugging support
>>> then kernel builds OK (including full mrproper cleanings in between):
>> 
>> BTW, one of the suggestions at the time was to try this:
> 
> Another thing is to ask which kernel version.  There's a number of fixes which recently went in to both -stable and -rc to fix problems with the decompressor.

>From first post (sorry to hear about your Internet connectivity woes Russell!):

> I'm working on a custom 2.6.33.2 port to Gumstix Verdex XL6P (PXA270) ...

The custom part is vanilla board support (missing stuff we don't care about like frame buffers and Bluetooth).

That's why I was so rattled by the decompression problems. I haven't been working anywhere near that.

I've not tried GZIP with the 4K -> 8K stack space Catalin mentioned.

Since I presently seem to have this Heisenbug somewhat cornered and reproducible if doing that and reporting the results would be helpful I'm happy to do so.

-Mike
