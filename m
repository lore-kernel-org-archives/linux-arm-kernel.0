From: tony@atomide.com (Tony Lindgren)
Date: Tue, 31 Jan 2012 09:20:09 -0800
Subject: [PATCH v2 00/19] ARM: OMAP3+: SmartReflex: bugfixes
In-Reply-To: <CAN5iSWo9+P=tC5Uq_bZ+Js_QPpGTn=Q6f5ecgiehRvT2E5+Diw@mail.gmail.com>
References: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
 <20120131170830.GJ9339@atomide.com>
 <CAN5iSWo9+P=tC5Uq_bZ+Js_QPpGTn=Q6f5ecgiehRvT2E5+Diw@mail.gmail.com>
Message-ID: <20120131172008.GK9339@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pihet-XID, Jean <j-pihet@ti.com> [120131 08:44]:
> Hi Tony,
> 
> On Tue, Jan 31, 2012 at 6:08 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Jean Pihet <jean.pihet@newoldbits.com> [120131 01:28]:
> >> Integrate the latest SmartReflex bufixes from Felipe Balbi [1] and
> >> Nishant Menon [2], plus misc bugfixes.
> >
> > We should move this to live under drivers somewhere. So
> Yes that is the plan, eventually.
> 
> > I'd like to see just minimal cleanup in the current location,
> > then move it to drivers before further patching.
> >
> > Is this the minimal cleanup needed before doing that, or
> > what's your plan regarding moving it to drivers?
> I would like to clean-up a few things and integrate well known
> bugfixes before the actual move to drivers/. Doing the opposite
> generates a rather big patch set (45+ patches to start with).
> 
> What do you think?

OK fine with me. So would the next patch after this series move
it to drivers then?

Regards,

Tony
