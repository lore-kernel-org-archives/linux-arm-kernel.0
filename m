From: sean.wang@mediatek.com (Sean Wang)
Date: Wed, 19 Sep 2018 10:54:10 +0800
Subject: [PATCH v2 00/22] Unify MediaTek pinctrl in preparation for
 MT8183 and MT6765
In-Reply-To: <CACRpkdZtVBjYGs5C7-HWEyX7f7pnCqvnRYBH=fFmLKhN4FGymA@mail.gmail.com>
References: <cover.1536404280.git.sean.wang@mediatek.com>
 <CACRpkdZtVBjYGs5C7-HWEyX7f7pnCqvnRYBH=fFmLKhN4FGymA@mail.gmail.com>
Message-ID: <1537325650.572.9.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-09-18 at 15:07 -0700, Linus Walleij wrote:
> On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:
> 
> > v2 and changes since v1:
> 
> I had trouble applying the last patches in the series so I applied
> all on an immutable branch (ib-mtk) then merged that into devel
> and added a patch on top to fix up some GPIO includes (just sent).
> 
> Please check the result!
> 

Sure, I'll take a look and and test on the devel branch.

On the top, I'll add a fix for the issue recently reported by kbuild
test robot about implicit declaration and a new MT6765 driver based
on the series.

> Yours,
> Linus Walleij
