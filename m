From: sameo@linux.intel.com (Samuel Ortiz)
Date: Sat, 22 Sep 2012 00:14:22 +0200
Subject: [V4 3/4] power_supply: Enable battery-charger for 88pm860x
In-Reply-To: <20120920223505.GA29721@lizard>
References: <20120714081254.GD20018@lizard>
 <1343377636-16128-1-git-send-email-jtzhou@marvell.com>
 <20120823034815.GB16674@lizard> <20120823044348.GA415@lizard>
 <CACDDiy-ZzUxi4MvjELwHzYC+AxF0b0+LuOh=JdFBBgSA2ijjNw@mail.gmail.com>
 <20120823122239.GA29485@lizard>
 <CAN1soZy-O2DGH89QwhBOiR=1+cv81t779EwwcYevU68bLkMdfQ@mail.gmail.com>
 <20120920223505.GA29721@lizard>
Message-ID: <20120921221422.GA28670@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anton,

On Thu, Sep 20, 2012 at 03:35:05PM -0700, Anton Vorontsov wrote:
> On Thu, Sep 13, 2012 at 03:48:11PM +0800, Haojian Zhuang wrote:
> > On Thu, Aug 23, 2012 at 8:22 PM, Anton Vorontsov
> > <anton.vorontsov@linaro.org> wrote:
> > > On Thu, Aug 23, 2012 at 05:06:22PM +0800, jett zhou wrote:
> > >> Thanks for helping me to amend these patch.  I got many good
> > >> suggestions and learn a lot in this process:) BTW, you mean you will
> > >> help to amend that several minor warning with battery tree?
> > >
> > > Yup, I have these small fixups locally in my tree already, so if/once
> > > Samuel gives me an Ack for the mfd part, I'll merge it into battery git
> > > tree.
> > 
> > Any updates?
> 
> OK, I guess I can just go ahead and apply it, the MFD changes are very
> trivial anyway. So, this is now applied (along with some fixups that
> I was talking about in my previous reply).
Applying this patch as is will not build as the mfd_add_devices() API has
changed. Either you rebase your patchset on top of Linus tree or I take this
patch and fix the mfd_add_devices() call. Please let me know how you want to
proceed.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
