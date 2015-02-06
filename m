From: olof@lixom.net (Olof Johansson)
Date: Fri, 6 Feb 2015 00:00:05 -0800
Subject: [GIT PULL] at91: cleanup/soc for 3.20 #4 (bis)
In-Reply-To: <1422905274-9303-1-git-send-email-nicolas.ferre@atmel.com>
References: <CAOesGMhycUD4ZfQccjD=zzRB901u0YT1NqCuA7chNTnvgt7Fsg@mail.gmail.com>
 <1422905274-9303-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150206080005.GA23582@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 08:27:54PM +0100, Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> As advised by Olof, here is a second attempt with this pull-request but this
> time with the at91-3.19-fixes branch as a base. Here is how I did it:
> - took v3.19-rc4
> - merged my at91-3.19-fixes branch that is now in Linus' tree
> - merged my at91-cleanup3 tag that you already have in your "soc" branch. These
>   patches obviously depend on this tag.
> - stacked the contend of this cleanup/soc pull-request.

Yep -- only tweak is that next time you could either start with your cleanup3
tag and just merge fixes, or start with fixes and merge cleanup3 -- no need to
do an explicit merge of fixes on top of mainline.

Anyway, that's just a very minor detail. I've merged this now, thanks for
respinning!


-Olof
