From: olof@lixom.net (Olof Johansson)
Date: Tue, 28 Jan 2014 10:22:31 -0800
Subject: [PATCH V2 1/2] ARM: multi_v7_defconfig: update for v3.13-rc1
In-Reply-To: <14397edee7978df1d80e048d7cd02c826a91af56.1390932990.git.jason@lakedaemon.net>
References: <1390871129-4838-1-git-send-email-jason@lakedaemon.net>
 <14397edee7978df1d80e048d7cd02c826a91af56.1390932990.git.jason@lakedaemon.net>
Message-ID: <CAOesGMh3qho=-3sN2-ju_-npggLSvD-s4Mnwt0EyVVh+YT7jYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 10:20 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> Just the output of:
>
>   make ARCH=arm multi_v7_defconfig
>   make savedefconfig
>   mv defconfig arch/arm/configs/multi_v7_defconfig
>
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>

Do you mean 3.14-rc1? If so, this will likely have conflicts with the
multi_v7_defconfig that we still have in our for-next branch (should
be queued in a regular branch now that all the contents has been
merged in by Linus).


-Olof
