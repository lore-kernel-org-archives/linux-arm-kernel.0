From: gnurou@gmail.com (Alexandre Courbot)
Date: Mon, 8 Apr 2013 17:07:54 -0700
Subject: GENERIC_GPIO considered deprecated
In-Reply-To: <20130409093842.656ae3fff92d5368db5c0646@canb.auug.org.au>
References: <CAAVeFu+QUw1WmzwaJDfjyw75PrStd3p3PHs1MU5BC7_WXMB7kw@mail.gmail.com>
 <2c9501ce342b$1535d290$3fa177b0$%kim@samsung.com>
 <5162EC32.2030602@wwwdotorg.org> <201304082136.44905.arnd@arndb.de>
 <20130409093842.656ae3fff92d5368db5c0646@canb.auug.org.au>
Message-ID: <CAAVeFuJCxYiOXRkjJZXpSFUaGoiAtWwBWBJmxXUyQMkmrSEsew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 8, 2013 at 4:38 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> On Mon, 8 Apr 2013 21:36:44 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Monday 08 April 2013, Stephen Warren wrote:
>> > >>
>> > >> Should do the trick, if we can make sure that your tree is merged
>> > >> prior to my patches.
>> > >
>> > > I'm not sure but I think, arm-soc tree should be merged into mainline before others...
>> > >
>> > >> Can you put it into your tree for 3.10?
>> > >>
>> > > I did, so it should be fine.
>> > >
>> >
>> > You may want to discuss how to handle this dependency with the arm-soc
>> > maintainers (CC'd).
>>
>> I'm fine with putting the same branch into arm-soc as well as the gpio tree
>> and anything else that might need it, that tends to be the least invasive
>> way.
>
> Just a reminder: that had better be the exact same branch and that branch
> had better never be rebased/rewritten ...

Sorry, which branch are we talking about - is it the one I published
for -next initially? If so wouldn't it be simpler to withdraw it and
have Grant integrate the patches in his branch? Since no one depends
on them for now anyway...

I remember rebasing it once some time ago to add Acked-bys, but it
hasn't changed since then.

Alex.
