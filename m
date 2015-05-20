From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 20 May 2015 11:16:46 +0200
Subject: linux-next: manual merge of the samsung tree with the arm-soc
 and at91 trees
In-Reply-To: <CAJKOXPdsi-5kdQJtybeaMCy0DXuRTRGgBEOM=SH9BsjquEMjCQ@mail.gmail.com>
References: <20150520102743.3d336a73@canb.auug.org.au>
 <CAJKOXPdsi-5kdQJtybeaMCy0DXuRTRGgBEOM=SH9BsjquEMjCQ@mail.gmail.com>
Message-ID: <20150520091646.GF3338@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/2015 at 09:35:36 +0900, Krzysztof Kozlowski wrote :
> 2015-05-20 9:27 GMT+09:00 Stephen Rothwell <sfr@canb.auug.org.au>:
> > Hi Kukjin,
> >
> > Today's linux-next merge of the samsung tree got a conflict in
> > arch/arm/configs/multi_v7_defconfig between various commits from the
> > arm-soc and at91 trees and various commits from the samsung tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary (no action
> > is required).
> 
> Hi,
> 
> Thanks for the merge.
> 
> The parts coming from samsung-soc related to manually toggling stuff
> (by me and Javier) look fine. The rest (coming from Kukjin's
> savedefconfig) I don't know - too much of them.
> 

Hum, last time I asked, we were not supposed to do a savedefconfig on
multi_v7...

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
