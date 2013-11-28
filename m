From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 28 Nov 2013 15:43:47 +0000
Subject: ACPI
In-Reply-To: <CAHCPf3ubLbeEGN-M-GW=ZByH48s=WxMTuWFhEs0mBhuXjUOAMQ@mail.gmail.com>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <CAHCPf3t-dKc-xwjLCEWrY6kmi4_dLHp4iMgOwdEJ43UGK9=khQ@mail.gmail.com>
 <20131127141634.A45F3C404EC@trevor.secretlab.ca>
 <CAHCPf3ubLbeEGN-M-GW=ZByH48s=WxMTuWFhEs0mBhuXjUOAMQ@mail.gmail.com>
Message-ID: <CACxGe6tM3rQy2vyGXbOo60fUL0d8FWAOdLVOn=ovQSmS=Qnagw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 Nov 2013 22:17, "Matt Sealey" <neko@bakuhatsu.net> wrote:
>
> On Wed, Nov 27, 2013 at 8:16 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Tue, 26 Nov 2013 17:11:23 -0600, Matt Sealey <neko@bakuhatsu.net> wrote:
> >> On Tue, Nov 26, 2013 at 12:33 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> >> > On Tue, Nov 26, 2013 at 12:55:10PM +0000, Grant Likely wrote:
> >> >> On Tue, Nov 26, 2013 at 12:43 PM, Linus Walleij
> >> >> <linus.walleij@linaro.org> wrote:
> >> >> > I have a feeling we should not recommend ARM implementers
> >> >> > to go and do things like this.
> >>
> >> I have a real problem with the concept of putting device trees inside
> >> ACPI, while still relying on this consensus that the preferred boot
> >> method will also be UEFI.
> >
> > ACPI and UEFI are completely separate things.
>
> Good lord, Grant. I have a working knowledge of both..

We're obviously getting crossed wires. I apologize for
misunderstanding. Yes, LinuxLoader is an obsolete hack. Roy Franz has
patches to port the x86 EFI_STUB to arm. I was merely using
LinuxLoader as evidence that having DT support in Tianocore should not
be a problem.

g.
