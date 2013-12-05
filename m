From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 5 Dec 2013 15:26:38 -0800
Subject: [PATCH 0/3] ARM Coresight: Enhance ETM tracing control
In-Reply-To: <52A101F8.3060104@codeaurora.org>
References: <20131204070442.GA31665@kroah.com>
 <CANsc=4UHEG5cmg9SD3r3rsuJnM9zqq2WiTQdUwrYFr_kkbsVvg@mail.gmail.com>
 <20131204170703.GA14859@kroah.com>
 <CANsc=4X7ThCvgz9bfu1ZZg9FCti5SMdbXL5tA584z-oZ_HEByg@mail.gmail.com>
 <20131204230239.GB9205@kroah.com>
 <CANsc=4UGi5sMdUW5qQDzEJx4h8NDU+-b=xOLBAZtzbV5ugz3Fg@mail.gmail.com>
 <20131205040104.GA14641@kroah.com>
 <52A0DE42.3080602@codeaurora.org>
 <20131205201659.GA14539@kroah.com>
 <52A101F8.3060104@codeaurora.org>
Message-ID: <20131205232638.GC28396@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 05:45:12PM -0500, Christopher Covington wrote:
> On 12/05/2013 03:16 PM, Greg Kroah-Hartman wrote:
> > On Thu, Dec 05, 2013 at 03:12:50PM -0500, Christopher Covington wrote:
> [...]
> > And adding new features to code that is "dead" and should probably be
> > removed isn't a good idea, as I'm sure you can understand.
> 
> I would consider feature additions to be a sign of life. Maybe the
> architecture or user interface isn't ideal, but would you suggest just as
> quickly for media codec or cryptography hardware support be removed?

No, but I would ask that they be moved to use the same userspace api
for the same functionality, and not create custom ones just because
"they can".

> > How much work is it to incorportate ETM into the perf framework?  Don't
> > you think that this is a better thing to do overall, instead of having
> > duplicating interfaces for the same thing?
> 
> I'm not familiar enough with the ETM hardware (and the ETB, the buffer where
> the data is stored) and driver to say. One factor may be whether the perf
> events framework would need to be extended for complete functionality or could
> be used as-is.

How about moving this conversation to the proper mailing list for this
type of thing then?

thanks,

greg k-h
