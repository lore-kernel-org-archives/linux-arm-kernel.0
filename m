From: olof@lixom.net (Olof Johansson)
Date: Fri, 2 Nov 2018 22:31:07 -0700
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
In-Reply-To: <20181103145752.6c1d10c8@canb.auug.org.au>
References: <20181103145752.6c1d10c8@canb.auug.org.au>
Message-ID: <CAOesGMjXPKE21tcVRurGKArUP8ogGBYZ6t7ZmDe2h0iyapneiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like I accidentally rebased the fixes branch locally after
merging that patch in. Will fixup, thanks for reporting.


-Olof

On Fri, Nov 2, 2018 at 8:58 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   cda58c80fe27 ("ARM: OMAP1: ams-delta: Fix impossible .irq < 0")
>
> is missing a Signed-off-by from its committer.
>
> --
> Cheers,
> Stephen Rothwell
