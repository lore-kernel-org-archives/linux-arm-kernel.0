From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 21 Apr 2017 23:31:25 +0200
Subject: linux-next: manual merge of the pm tree with the arm-soc tree
In-Reply-To: <e2f9efab-291f-1436-2176-0fff3f2aae3f@oracle.com>
References: <20170421105405.6a690b35@canb.auug.org.au>
 <CAK8P3a0cVMt3y_oYH70V-ekPvUMeeBApSvybpRftSupzYy1FWQ@mail.gmail.com>
 <e2f9efab-291f-1436-2176-0fff3f2aae3f@oracle.com>
Message-ID: <1721375.qoxY63CZOC@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 21, 2017 02:02:35 PM santosh.shilimkar at oracle.com wrote:
> 
> On 4/21/17 2:31 AM, Arnd Bergmann wrote:
> > On Fri, Apr 21, 2017 at 8:39 AM, santosh.shilimkar at oracle.com
> > <santosh.shilimkar@oracle.com> wrote:
> >> On 4/20/17 10:53 PM, Arnd Bergmann wrote:
> >>>
> >>> On Fri, Apr 21, 2017 at 2:54 AM, Stephen Rothwell <sfr@canb.auug.org.au>
> >>> wrote:
> >>>>
> >>>> Hi all,
> >>>>
> >>>> Today's linux-next merge of the pm tree got a conflict in:
> >>>>
> >>>>   include/dt-bindings/genpd/k2g.h
> >>>>
> >>>> between commit:
> >>>>
> >>>>   7cc119f29b19 ("dt-bindings: Add TI SCI PM Domains")
> >>>>
> >>>> from the arm-soc tree and commit:
> >>>>
> >>>>   45da8edd1741 ("dt-bindings: Add TI SCI PM Domains")
> >>>>
> >>>> from the pm tree.
> >>>>
> >>>> I fixed it up (I just used the pm tree version) and can carry the fix as
> >>>> necessary. This is now fixed as far as linux-next is concerned, but any
> >>>> non trivial conflicts should be mentioned to your upstream maintainer
> >>>> when your tree is submitted for merging.  You may also want to consider
> >>>> cooperating with the maintainer of the conflicting tree to minimise any
> >>>> particularly complex conflicts.
> >>>
> >>>
> >>> Dave, Santosh,
> >>>
> >>> any idea what happened here? It seems that we picked up the wrong
> >>> version of the tree, do we need to drop this from arm-soc?
> >>>
> >> Nope. Its because this series was in my 'next' branch for a week or
> >> so and now it made it via arm-soc tree next as well.
> >>
> >> I just cleaned up my next head so it linux-next next tag should have
> >> only arm-soc copy.
> >
> > I still see two conflicting trees in linux-next as of today, neither of
> > them is your keystone tree:
> >
> In the list it was agreed that the patchset goes via arm-soc tree.

OK, I missed that when I looked at it again a couple of days ago, sorry.

I'll drop it from the pm-domains branch.

Thanks,
Rafael
