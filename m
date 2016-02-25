From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 16:05:08 -0800
Subject: [GIT PULL] Versatile family DT cleanups step 1
In-Reply-To: <CACRpkdYR-_41Ay7b_X4hJkPY7dUR2qAsfsjn-MzpahVWqEiVPQ@mail.gmail.com>
References: <CACRpkdYR-_41Ay7b_X4hJkPY7dUR2qAsfsjn-MzpahVWqEiVPQ@mail.gmail.com>
Message-ID: <20160225000508.GZ10126@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 10:07:38AM +0100, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> this is a first pull request for my cleanups for the Versatile, as the
> finished stuff should not be sitting in my tree but in ARM SoC.
> This completes the ARM RealView PB1176 and PB11MPCore
> device trees, and moves the Versatile to use power/reset.
> 
> The idea is to keep working on this cleanup branch and send
> additional patches on top of this one as the prerequisites are
> merged into the MTD and FBDEV subsystems. So please create
> a special versatile cleanup branch (or suggest another approach).
> 
> As it happens, board files and device trees need to change at the
> same time to make logical sense, especially for Versatile where
> auxdata is replaced with DT entries, such as when reset is moved
> in the last patch in this set. The MTD and CLCD changes will share
> this characteristic.
> 
> Please pull it in!
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> 
>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> tags/versatile-dt-cleanup-1
> 
> for you to fetch changes up to 1c6e288da6cc3c72579ff0062b5a5684fb9ef90e:
> 
>   ARM: versatile: move restart to the device tree (2016-02-15 09:58:08 +0100)

THanks. I've merged this into next/dt, seemed as good as any. Only think
I'm asking is to not modify these board files in another branch so we
can avoid conflicts -- but incremental stuff on top is just fine.


-Olof
