From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jun 2013 23:10:34 +0100
Subject: getting allwinner SoC support upstream (was Re: Uploading
 linux (3.9.4-1))
In-Reply-To: <20130605213845.GX11182@csclub.uwaterloo.ca>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <CAKON4OxDD5orX2w-_+d5kawTGXbE3KKj2QLERo9m7=NiUSXhgQ@mail.gmail.com>
 <51AFA6DD.3000202@wwwdotorg.org>
 <CAPweEDz=hFxXW3XF9CSNZpEFSjayb5an1E8Xze1_uQcCZONVxg@mail.gmail.com>
 <20130605213845.GX11182@csclub.uwaterloo.ca>
Message-ID: <20130605221034.GK18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 05:38:45PM -0400, Lennart Sorensen wrote:
> I haven't personally dealt with any nvidia arm devices, so I have no
> idea how those are turning out, nor have I looked much at the marvell
> ones yet (even though I have a cubox sitting on my desk I intend to play
> around with).

Cubox is Dove, which dates from way before DT on ARM, and there's
relatively few people working on Dove support, so progress towards
DT support is rather slow there.  I believe it to be at the point
where it's possible to boot the Cubox using DT, but not all features
are supported.

But then, not all features of the Dove SoC are supported in mainline
either; the port essentially stopped after a little more than basic
support was merged.  Eg, no hardware monitoring driver, no video
drivers, etc...
