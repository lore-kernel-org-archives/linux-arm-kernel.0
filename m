From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Tue, 07 Aug 2012 18:20:59 +0200
Subject: Custom platform for commercial device
In-Reply-To: <20120807161333.GF18957@n2100.arm.linux.org.uk>
References: <50213ABE.6070305@gmail.com>
 <20120807161333.GF18957@n2100.arm.linux.org.uk>
Message-ID: <5021406B.4040302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
On 08/07/2012 06:13 PM, Russell King - ARM Linux wrote:
> On Tue, Aug 07, 2012 at 05:56:46PM +0200, Ga?tan Carlier wrote:
>> Hello,
>> I have license related questions :
>
> You should ask your solicitor these questions.
>
> **** DISCLAIMER ****
> What is below is my understanding of the GPL license, which is the
> only license which allows you to make use of the Linux kernel - which
> includes a substantial amount of code authored by myself.
>
>> 1) if I create and sell a device which is a fork of an existing
>> platform, should I have to publish code of this new platform and/or give
>> the code to customer if he asks it ?
>
> The GPL gives you essentially two options - one of them is that you
> supply your products with a copy of the _full_ machine-readable source
> code which was used to generate the GPL licensed executables.  See 3(a).
>
> The second option is that you provide a written offer of the source
> code to anyone who buys your product.  You must supply a copy of the
> source to anyone who has bought your product within three years of
> that purchase taking place.  See 3(b).
>
> 3(c) also comes into play if you decide to go down this route, because
> it's not only your direct customers who can request a copy of the source,
> it's anyone who _they_ have passed your product or the binaries in your
> product to.  So the effect of 3(b) + 3(c) is that you have to supply
> anyone who requests a copy of the source with it.
>
Sorry, after reading COPYING, I found answers for this question but I 
forgot to remove this question from my draft.

>> 2) Should I have to mention that my device is powered by Linux kernel ?
>> For a PC software, the GPL must be displayed at installation time but
>> for embedded devices (ie. if a closed source software is used to send
>> new kernel to the device) ?
>
> 2(c) comes into play for this.  I believe the Linux kernel not to be an
> interactive program (it isn't gdb.)  Therefore, it doesn't display a
> GPL notice at startup, and therefore there's no need for it to display
> such a notice at boot time.
>
> It would be nice if manufacturers would credit where they got a
> substantial amount of code from in their products, whether it be in a
> manual or something, but the GPL does not explicitly require it.
>
> Note that what you aren't able to do is to remove or prevent any GPL'd
> program which already displays its license from doing so when
> incorporating it in a product.
>
>> 3) Can I send patches to this list to add this new platform to be able
>> maintain it more easily when kernel change implementation of some drivers
>> ?
>
> We always encourage that, provided the code isn't just "chucked over the
> wall" at us.  In other words, we'd like any code that makes its way into
> the kernel to be maintained and used.  Otherwise, it becomes a maintenance
> burden, and will eventually be removed.
>
> And here's a reminder of the disclaimer:
> **** DISCLAIMER ****
> What is above is my understanding of the GPL license, which is the
> only license which allows you to make use of the Linux kernel - which
> includes a substantial amount of code authored by myself.
>
Thanks.
Regards,
Ga?tan Carlier.
