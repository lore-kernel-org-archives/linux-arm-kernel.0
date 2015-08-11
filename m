From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Aug 2015 15:16:53 +0200
Subject: [GIT PULL] Broadcom Device Tree changes for 4.3 (part 2)
In-Reply-To: <1438796683-18581-1-git-send-email-f.fainelli@gmail.com>
References: <1438796683-18581-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <20150811131653.GH30181@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 05, 2015 at 10:44:41AM -0700, Florian Fainelli wrote:
> The following changes since commit ee224e175e9d837b3d572e863ac96109b58707ac:
> 
>   Merge tag 'mvebu-dt-4.3-2' of git://git.infradead.org/linux-mvebu into next/dt (2015-08-05 11:10:30 +0200)

This isn't quite right. Please don't base your branches on top of our
next/* branches. Instead they should be based on a plain -rc from upstream
or, if needed, preceding versions of your own branches.

In this case I've just taken the three patches and applied them directly, so
no need to respin the branch this time.


-Olof
