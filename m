From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Sep 2014 11:16:25 -0700
Subject: [GIT PULL] arm: mediatek: Add more basic features
In-Reply-To: <CABuKBeJJ5ijy6CXPHbrzrkgJDVz99BmdACx+wRZ-KbVjKx2kLg@mail.gmail.com>
References: <CABuKBeJJ5ijy6CXPHbrzrkgJDVz99BmdACx+wRZ-KbVjKx2kLg@mail.gmail.com>
Message-ID: <20140924181625.GE19284@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 05:59:28PM +0200, Matthias Brugger wrote:
> Hi Arnd and Olof,
> 
> Please prepare for the next round of Mediatek patches for the mt6589.
> This patch set adds some minor changes to the Mediatek mt6589 support.
> 
> Features are low-level debugging on the mt6589, the addition to the
> "make dtbs" and multi_v7_defconfig,as well as some small changes in
> the DTS files.

Hi Matthias,

The contents in this branch look OK to me, but I'd prefer to spread them out
across some of our branches (most of it is DT, one is defconfig and one is soc stuff).

Because of this, I've ended up applying patches manually (cherry-picking them out of this branch).

In other words: Code is merged, but branch is not. Thanks!

(Also, we tend to use a capital ARM: as prefix on patch subjects, I fixed that up).


-Olof
