From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 9 Apr 2013 09:38:42 +1000
Subject: GENERIC_GPIO considered deprecated
In-Reply-To: <201304082136.44905.arnd@arndb.de>
References: <CAAVeFu+QUw1WmzwaJDfjyw75PrStd3p3PHs1MU5BC7_WXMB7kw@mail.gmail.com>
 <2c9501ce342b$1535d290$3fa177b0$%kim@samsung.com>
 <5162EC32.2030602@wwwdotorg.org> <201304082136.44905.arnd@arndb.de>
Message-ID: <20130409093842.656ae3fff92d5368db5c0646@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Mon, 8 Apr 2013 21:36:44 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Monday 08 April 2013, Stephen Warren wrote:
> > >>
> > >> Should do the trick, if we can make sure that your tree is merged
> > >> prior to my patches.
> > > 
> > > I'm not sure but I think, arm-soc tree should be merged into mainline before others...
> > > 
> > >> Can you put it into your tree for 3.10?
> > >>
> > > I did, so it should be fine.
> > > 
> > 
> > You may want to discuss how to handle this dependency with the arm-soc
> > maintainers (CC'd).
> 
> I'm fine with putting the same branch into arm-soc as well as the gpio tree
> and anything else that might need it, that tends to be the least invasive
> way.

Just a reminder: that had better be the exact same branch and that branch
had better never be rebased/rewritten ...

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130409/1f974ace/attachment-0001.sig>
