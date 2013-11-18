From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 19 Nov 2013 00:34:41 +0100
Subject: ACPI vs DT at runtime
In-Reply-To: <CAOesGMh373ZsLzoGHJm+xV3uFVjh2CBSA8SXY4PA+VxL3a5W1w@mail.gmail.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131118232536.GF1567@rocoto.smurfnet.nu>
 <CAOesGMh373ZsLzoGHJm+xV3uFVjh2CBSA8SXY4PA+VxL3a5W1w@mail.gmail.com>
Message-ID: <20131118233441.GA22634@rocoto.smurfnet.nu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hej,

On Mon, Nov 18, 2013 at 03:29:58PM -0800, Olof Johansson wrote:
> >> The server guys really want UEFI for their boot protocols,
> >> installation managers, etc, etc. That's fine, let them do that, but
> >> that doesn't mean we need to bring the same APIs all the way into the
> >> kernel.
> >
> > There is zero dependency on ACPI in the UEFI support code, or indeed in
> > UEFI itself. Both runtime services support and stub loader have been
> > designed hardware-description agnostic.
> >
> > Are you saying that we should not support the kernel interfaces to UEFI
> > on ARM*, or are you simply mentioning it in passing because it is the
> > bit responsible for populating the pointer to the ACPI tables?
> 
> Good question. UEFI and ACPI usually gets grouped together when they
> really are separate (even though ACPI _without_ UEFI is highly
> unlikely).
> 
> So, to clarify: What I meant with the above is that UEFI as a
> bootloader is fine as far as I am concerned. I'm also in general ok
> with the introduction of efivars that you're doing, etc.

Thank you for this clarification.

/
    Leif
