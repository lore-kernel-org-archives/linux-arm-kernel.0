From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Mar 2012 12:34:10 +0000
Subject: [GIT PULL 1/5] ARM: cleanups of io includes
In-Reply-To: <CAOesGMjwZOON9kFNvaEq8QhSvjAgsJT_J1Ysb9-AbePd6g+-rQ@mail.gmail.com>
References: <1332918842-13521-1-git-send-email-olof@lixom.net>
 <20120328082501.GA22414@n2100.arm.linux.org.uk>
 <CAOesGMjwZOON9kFNvaEq8QhSvjAgsJT_J1Ysb9-AbePd6g+-rQ@mail.gmail.com>
Message-ID: <201203281234.10632.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 March 2012, Olof Johansson wrote:
> If you prefer to let it sit in linux-next for a day or two before
> going in, that's fine. But I verified that the original build problem
> introduced was fixed before I sent it out.
> 
> Unfortunately, PXA is also broken due to the regulator changes
> mentioned in the above referenced mail, which is already upstream and
> unrelated to the changes in this branch.
> 
> Linus; the rest of the pull requests should be OK to go in
> independently of this, so please go ahead with those if you don't
> mind. The only changes to those branches in the last few days is the
> merge resolution I did to the drivers2 branch/tag.

Yes, sounds good. I've also verified that none of the other branches
depends on this one.

	Arnd
