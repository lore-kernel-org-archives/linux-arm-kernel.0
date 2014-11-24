From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Nov 2014 15:24:09 +0100
Subject: [PATCH RESEND 0/3] ARM: Meson6: enable SMP
In-Reply-To: <CAOQ7t2amsAvD_O6XO_jF9NRhAAWrG+_URKNytmY-6aUE+wchnA@mail.gmail.com>
References: <1415982353-9293-1-git-send-email-carlo@caione.org>
 <CAOQ7t2amsAvD_O6XO_jF9NRhAAWrG+_URKNytmY-6aUE+wchnA@mail.gmail.com>
Message-ID: <283984248.2HBkCzgaiV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 23 November 2014 12:48:31 Carlo Caione wrote:
> On Fri, Nov 14, 2014 at 5:25 PM, Carlo Caione <carlo@caione.org> wrote:
> > Amlogic Meson6 is a dual-core Cortex-A9. This patchset adds all the necessary
> > pieces to boot the secondary CPU.
> >
> > ---
> >
> > This is a resend of a patchset already submitted a while ago
> > http://www.spinics.net/lists/arm-kernel/msg366787.html
> >
> 
> Ping

Hi Carlo,

Is this for arm-soc? I guess from the contents that it is, but you had
10 people in 'To', and you don't say in the introductory mail what
you would like to happen with these patches.

When you send something for inclusion in arm-soc, please always send
it 'To: arm at kernel.org' with everyone else on Cc instead of To,
and be explicit with whether you think the contents are ready to
be merged or whether you would like to see more review.

	Arnd
