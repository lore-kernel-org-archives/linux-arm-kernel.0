From: olof@lixom.net (Olof Johansson)
Date: Tue, 6 Dec 2016 11:03:34 -0800
Subject: [RFC PATCH 00/23] arm: defconfigs: use kconfig fragments
In-Reply-To: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
References: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <CAOesGMi6gqNLUZw_bQZE2foBts0c70z57bHcMVg1hVZ_E4easg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 6, 2016 at 4:38 AM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Hi,
>
> This RFC patchset starts convertion of ARM defconfigs to use kconfig
> fragments and dynamically generate defconfigs.  The goals of this
> work are to:

You don't provide any motivation as to why this is better. As far as I
am concerned it'll just be a mess.

So:

Nack. So much nack. I really don't want to see a proliferation of
config fragments like this.

I had a feeling it was a bad idea to pick up that one line config
fragment before, since it opened the door for this kind of mess. :(



-Olof
