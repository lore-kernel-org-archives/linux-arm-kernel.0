From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Jul 2014 22:12:49 -0700
Subject: [GIT PULL] Versatile/Integrator base cleanup patches
In-Reply-To: <CACRpkdbMA2oCFJmKH91MSg4hA0dxGcgAzy=ph1YOBLkN6-KxZA@mail.gmail.com>
References: <CACRpkdbMA2oCFJmKH91MSg4hA0dxGcgAzy=ph1YOBLkN6-KxZA@mail.gmail.com>
Message-ID: <20140708051249.GE28931@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 10:23:42AM +0200, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> these are the first basic patches at the very bottom of my
> multiplatform stack, getting some infrastructure in place to
> do the final transition to multiplatform for Integrator (still
> working on the final patch) and also paving the road a bit
> for Versatile and RealView but continuing to depopulate
> plat-versatile.
> 
> Please pull it in as a starter, I'd recommend a common
> Versatile branch to be shared with e.g. Rob Herrings Versatile
> devicetree stuff.
> 
> Yours,
> Linus Walleij
> 
> 
> The following changes since commit a497c3ba1d97fc69c1e78e7b96435ba8c2cb42ee:
> 
>   Linux 3.16-rc2 (2014-06-21 19:02:54 -1000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> tags/versatile-1
> 
> for you to fetch changes up to 11c32d7b6274cb0f554943d65bd4a126c4a86dcd:
> 
>   video: move Versatile CLCD helpers (2014-06-27 10:15:22 +0200)
> 
> ----------------------------------------------------------------
> First pull request of Versatile family clean-ups for v3.17:
> 
> - Remove <mach/memory.h> from the Integrator, paving the
>   road for multiplatform.
> - Push the CLCD helper code down into the framebuffer subsystem,
>   removing the last hook in plat-versatile for the Integrator,
>   also paving the road for multiplatform.
> 
> Patches tested on Integrator/AP, Integrator/CP and Versatile AB
> (all real hardware).

Merged, thanks!


-Olof
