From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 29 Oct 2014 13:08:21 +0200
Subject: [linux-sunxi] Re: [PATCH v4 0/5] simplefb: add clock handling code
In-Reply-To: <544F7E5D.60104@redhat.com>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
 <544F737A.7000109@ti.com>
 <CAL_JsqJ2JRg7k21CEVe4-At7enD+y3TN_7wfqhY0OHZm-_j17w@mail.gmail.com>
 <544F7E5D.60104@redhat.com>
Message-ID: <5450CAA5.5020205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans, Rob,

On 28/10/14 13:30, Hans de Goede wrote:
> Hi,
> 
> On 10/28/2014 12:11 PM, Rob Herring wrote:

>> Yes, I object to the binding still as it has not changed from what was
>> previously posted.
> 
> It would be helpful if you could explain why you object. Last time you
> said: " You are mixing in a hardware description that is simply inaccurate."
> 
> I then explained that this is not hardware description, but runtime state
> information, as it tells the kernel which clocks were chosen to drive the
> display (out of typically a list of possible options, depending on which
> output is used, etc.). Just like which memory address the bootloader has
> chosen to scan out the video image from.
> 
> Then you got quiet, so sorry, but this time your objection really is too
> late. You cannot simply go quiet halfway through a discussion and then pop
> up again when a new version is posted to say "I object" yet another time,
> you've had your chance to make your arguments last time, and chose to stay
> quiet after I explained in detail that this is not hardware description but
> state information, so now it is simply too late.
> 
> These bindings have been discussed at Plumbers with various interested people
> present, and the conclusion was that this really is the best way to handle this,
> so this patch is:
> 
>     Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>     Reviewed-by: Mike Turquette <mturquette@linaro.org>
>     Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>     Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> And David Herrman who is working on simpledrm, which will be merged soon, which
> will also use the simplefb bindings also agrees. So we have the simplefb maintainer,
> simpledrm maintainer, and the clk subsystem maintainer + 2 other maintainers all
> agreeing on a way forward, the time for bikeshedding now really really really is
> over.
> 
> Tomi, can you please let us know how you plan to proceed with this ?

I won't merge DT bindings via fbdev tree, if a DT maintainer says no.

I took Rob's silence to the earlier series as a silent ack for your
explanation. Obviously that was not the case.

Rob, please advice asap what should be done to the bindings to get your
ack. As Hans explained above, this discussion has been going on for a
long time, and afaik this series is the best way forward of all the
options discussed.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141029/41c130bf/attachment.sig>
