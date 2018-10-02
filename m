From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 2 Oct 2018 13:10:44 +0200
Subject: [GIT PULL] ARM: dts updates for arm 32 bits for v4.20
In-Reply-To: <9f0dd563-b921-8d31-c82c-327fea5c026f@gmail.com>
References: <0195dc38-908e-c403-5f12-d266a037ca1b@gmail.com>
 <CAK8P3a1AVrP_vrvUJrEHp1i_LrdDCwCmiVP_aRYpATwEK+B3Yg@mail.gmail.com>
 <9f0dd563-b921-8d31-c82c-327fea5c026f@gmail.com>
Message-ID: <CAK8P3a0dih9hFib05L2C31ONnraxN67H4wJAzQWD9gMg2Ek1Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 2, 2018 at 12:34 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> On 02/10/2018 11:12, Arnd Bergmann wrote:
> > On Sat, Sep 29, 2018 at 5:18 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> >
> >> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> >>
> >>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
> >> tags/v4.19-next-dts32
> >>
> >> for you to fetch changes up to 5646a2f6d584e80bd4555c2ce3e286b35b9eaa61:
> >>
> >>   arm: dts: mt7623: add jpeg decoder device node (2018-09-25 17:44:35 +0200)
> >>
> >> ----------------------------------------------------------------
> >> mt7623:
> >> - add pmu node
> >> - add subsystem clock>> - add nodes needed for iommu
> >> - add node for the jpeg decoder
> >
> > None of these (aside from the pmu) seem to have DT bindings
> > or drivers posted on the list. Can you explain why that is and what
> > the plan is for supporting them?
> >
>
> We rely on the fallback compatible here, as mt2701 and mt7623 are identically in
> most of their components. If you require to get the bindings documented before
> merging the DT, then I propose to drop the pull request for now.
>
> Other option would be to get the bindings documented in v4.21. AFAIK up to now
> there haven't been sent any patches to update the bindings.

Ok, I missed that the mt2701 strings are all documented and used in drivers,
so I don't think it's a problem to merge your changes. How about you add
another patch to your tree to update the respective bindings? I think that
should be fine even for 4.20.

        Arnd
