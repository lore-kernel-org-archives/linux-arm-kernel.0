From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Dec 2013 00:23:45 +0000
Subject: [PATCH 0/3] ARM Coresight: Enhance ETM tracing control
In-Reply-To: <20131206000610.GA30344@kroah.com>
References: <20131204170703.GA14859@kroah.com>
 <CANsc=4X7ThCvgz9bfu1ZZg9FCti5SMdbXL5tA584z-oZ_HEByg@mail.gmail.com>
 <20131204230239.GB9205@kroah.com>
 <CANsc=4UGi5sMdUW5qQDzEJx4h8NDU+-b=xOLBAZtzbV5ugz3Fg@mail.gmail.com>
 <20131205040104.GA14641@kroah.com> <52A0DE42.3080602@codeaurora.org>
 <20131205201659.GA14539@kroah.com> <52A101F8.3060104@codeaurora.org>
 <CANsc=4Vb-2br+K51NWsyQV25R3eJo_=YfpnXsh1G1ecRVDYc3w@mail.gmail.com>
 <20131206000610.GA30344@kroah.com>
Message-ID: <20131206002345.GK4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 04:06:10PM -0800, Greg Kroah-Hartman wrote:
> On Thu, Dec 05, 2013 at 06:54:49PM -0500, Adrien Verg? wrote:
> > > Well, these patches were incorrect, so that's not really a valid
> > > question :)
> > 
> > Should I correct the pid size and send them again?
> 
> I'm not the ARM maintainer, so I can't say if I would reject them or
> not.

Neither am I someone who knows this code; it was contributed by TI, and
I assume TI had I use for it.  I've no idea what that was or how it's
even used - it's not something I particularly care about.

I'd much rather someone else who has a use for ETM (and thus knows what
it should/can do) look after it.
