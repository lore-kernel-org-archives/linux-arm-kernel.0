From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 26 Nov 2013 08:26:43 +0900
Subject: [PATCH] ARM: dts: Add max77686 RTC interrupt to cros5250-common
In-Reply-To: <CAOesGMhfioBLMgmFi7EHrkVys_96KKzBcLp0C8sdLaRs5FMJBw@mail.gmail.com>
References: <1382533861-12688-1-git-send-email-dianders@chromium.org>
 <CAD=FV=VHLHL-VxUr_G7CoBQ5UY8t1jbdTCwcGz9BYrR5C3cpAQ@mail.gmail.com>
 <CAOesGMhfioBLMgmFi7EHrkVys_96KKzBcLp0C8sdLaRs5FMJBw@mail.gmail.com>
Message-ID: <1ad301ceea35$cd1eb0f0$675c12d0$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Mon, Nov 25, 2013 at 3:11 PM, Doug Anderson <dianders@chromium.org>
> wrote:
> > Olof or Kukjin,
> >
> > On Wed, Oct 23, 2013 at 6:11 AM, Doug Anderson <dianders@chromium.org>
> wrote:
> >> Without the interrupt you'll get problems if you enable
> >> CONFIG_RTC_DRV_MAX77686.  Setup the interrupt properly in the device
> >> tree.
> >>
> >> Signed-off-by: Doug Anderson <dianders@chromium.org>
> >> ---
> >>  arch/arm/boot/dts/cros5250-common.dtsi | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >
> > Would one of you be interested in applying this to your tree, with
> > Marc's "Tested-by"?  I know there are lots more things to fixup in the
> > dts, but this is one that I know works.  ;)
> 
> Yes, I'll apply this to fixes for 3.13, and mark it for stable 3.12 at
> least.
> 
Olof, thanks.

Please add my ack on this if you want.

- Kukjin
