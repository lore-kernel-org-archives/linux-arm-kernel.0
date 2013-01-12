From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Jan 2013 09:16:51 -0800
Subject: [PATCH 0/4] arm: vt8500: Add support for Wondermedia WM8750/WM8850
In-Reply-To: <1357960044.8515.0.camel@gitbox>
References: <1357935162-7672-1-git-send-email-linux@prisktech.co.nz>
 <20130111215659.GA16521@quad.lixom.net>
 <1357960044.8515.0.camel@gitbox>
Message-ID: <20130112171651.GC24073@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 12, 2013 at 04:07:24PM +1300, Tony Prisk wrote:
> > I suggest that you split off the last three (and rebase them to be
> > independent), and apply them to a multiplatform branch for vt8500. Then the
> > last one is a soc branch that goes on top of the multiplatform branch (i.e. you
> > build it on top of multiplatform). That way we can pull in the multiplatform
> > changes together with those for other platforms, and then take the wm8{7,8}50
> > branch goes in with the other new-soc support from other platforms.
> > 
> > Does that make sense? I'll be happy to provide more explanation if it doesn't.
> > 
> > -Olof
> 
> I think I understand - pull requests to follow.

Looks good, thanks for fixing it up. Next time feel free to change to
fresh subjects on the pull requests. :)

I don't see your PGP key uploaded to the public key servers, and you
likely don't have it signed by anyone else. If you have a chance, please
try to get it signed by a few people. Ideal time to do that is if you're
going to any conferences, but there are also local people around the
world that can meet up sometimes.


-Olof
