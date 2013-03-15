From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 15 Mar 2013 19:59:54 +0100
Subject: [PATCH v3 3/3] leds: leds-pwm: Defer led_pwm_set() if PWM can
 sleep
In-Reply-To: <CAK5ve-+TfHmvx8fiim2yyZhKbhgieO-WDqd+HG7ViLm=Fk3zNA@mail.gmail.com>
References: <1359381659-24454-1-git-send-email-florian.vaussard@epfl.ch>
 <1359381659-24454-4-git-send-email-florian.vaussard@epfl.ch>
 <20130130081728.GC13568@avionic-0098.mockup.avionic-design.de>
 <512E2F98.6070404@epfl.ch> <51347B06.8090604@epfl.ch>
 <20130304105806.GA28735@avionic-0098.mockup.avionic-design.de>
 <513EFE17.6030203@epfl.ch>
 <CAK5ve-+TfHmvx8fiim2yyZhKbhgieO-WDqd+HG7ViLm=Fk3zNA@mail.gmail.com>
Message-ID: <20130315185953.GA11351@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 10:08:57AM -0700, Bryan Wu wrote:
> On Tue, Mar 12, 2013 at 3:06 AM, Florian Vaussard
> <florian.vaussard@epfl.ch> wrote:
> > Hi Bryan,
> >
> >
> >>>>>
> >>>>> Bryan, I assume that you'll be taking this? It doesn't apply cleanly to
> >>>>> my tree, probably because of Peter's recent changes that you took
> >>>>> through your tree and Florian based his patches on top of that. The
> >>>>> conflict resolution should be trivial, though.
> >>>>>
> >>>>
> >>>> It seems that this patch was not taken. Could you pull it, as the other
> >>>> part is already in linux-pwm? Or is there any show stopper?
> >>>>
> >>>
> >>> Ping? Who should merge this?
> >>
> >>
> >> I assume Bryan will take it through the LED tree? Patches 1 & 2 went
> >> into v3.9-rc1 through the PWM tree.
> >>
> >
> > Ping ?
> >
> 
> Hi Florian and Thierry,
> 
> Sorry, guys. My bad! I'm using GMAIL filtering my emails. This email
> goes into my arm-linux mail list archive and I totally missed it.
> 
> I can merge this patch into my for-next branch, but it will be in 3.10
> not 3.9-rcX.
> 
> Or Thierry, can you merge that to 3.9-rcX through your tree with my Ack?

I think 3.10 would be fine. We missed the merge window on this one and
it isn't really a fix so it's a bit late for 3.9 now.

If Florian really absolutely needs this it can probably be done, but if
he can wait another few weeks it's certainly worth taking it through
linux-next for a while just to be safe.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130315/5b9a96ce/attachment.sig>
