From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Jun 2015 16:32:17 +0200
Subject: [GIT PULL] ARM: mediatek: arm64 updates for v4.2
In-Reply-To: <CABuKBeK+LT4UDKe0P=vswEXTUevcSNTf2Gn0cdMQ7r=tj2JmOA@mail.gmail.com>
References: <CABuKBeLhFR=94cF301wL7J8hJVTtyseoD7g45PLE6znQkPAFGQ@mail.gmail.com>
 <2507882.daayE1Zgb4@wuerfel>
 <CABuKBeK+LT4UDKe0P=vswEXTUevcSNTf2Gn0cdMQ7r=tj2JmOA@mail.gmail.com>
Message-ID: <1461817.ARd56COj2q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 June 2015 10:56:35 Matthias Brugger wrote:
> 2015-06-01 10:11 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> >
> > If you put the same file in two branches, please use the same commit
> > ID. While git can figure it out when everything goes right, it will
> > fail horribly if one of the branches later gets a patch on top that
> > modifies the file, before the two branches get merged.
> 
> I just saw, that the commit in question has dependencies to other commits.
> So I decided I will drop the patches which cause problems. They should
> go into the next merge window.
> 

Ok, thanks. That will make it simpler for me.

	Arnd
