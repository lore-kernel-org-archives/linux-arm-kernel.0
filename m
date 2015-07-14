From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Jul 2015 23:54:01 -0700
Subject: [PATCH 3/3] ARM: dts: Fix frequency scaling on Gumstix Pepper.
In-Reply-To: <CAK8F28kxuk0zPetCBPLmU5skQcOb2E47veZe5s7YaeE-ZJNMew@mail.gmail.com>
References: <1433441299-18887-1-git-send-email-arun@gumstix.com>
 <1433441299-18887-4-git-send-email-arun@gumstix.com>
 <CAK8F28kxuk0zPetCBPLmU5skQcOb2E47veZe5s7YaeE-ZJNMew@mail.gmail.com>
Message-ID: <20150714065400.GD17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ash Charles <ashcharles@gmail.com> [150609 08:47]:
> This works well for me--cpufreq seems much happier.
> 
> Tested-by: Ash Charles <ashcharles@gmail.com>
> 
> On Thu, Jun 4, 2015 at 11:08 AM, Arun Bharadwaj <arun@gumstix.com> wrote:
> > The device tree for Gumstix Pepper has DCDC2 and
> > DCDC3 correctly labelled but the upper limit values
> > are wrong. The confusion is due to the hardware
> > quirk where the DCDC2 and DCDC3 wires are flipped
> > in Pepper.
> >
> > Signed-off-by: Arun Bharadwaj <arun@gumstix.com>

Applying into omap-for-v4.2/fixes thanks.

Tony
