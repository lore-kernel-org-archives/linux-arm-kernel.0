From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Jan 2015 11:14:38 -0800
Subject: [GIT PULL] CSR new atlas7 machine, and delete old marco machine
 for 3.20
In-Reply-To: <CAGsJ_4z=SOxGAcr_2BizVUvxY8NOx1swpHoSJVCPJ5xn7dh6vQ@mail.gmail.com>
References: <CAGsJ_4z=SOxGAcr_2BizVUvxY8NOx1swpHoSJVCPJ5xn7dh6vQ@mail.gmail.com>
Message-ID: <20150119191438.GC16883@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 09:25:54PM +0800, Barry Song wrote:
> Hi Arnd, Kevin, Olof,
> 
> The following changes since commit 98898ee43a94375cf814b86fb7f485c39fb2c072:
> 
>   ARM: sirf: add two debug ports for CSRatlas7 SoC (2015-01-14 20:56:09 +0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
> tags/new-atlas7mach-for-3.20
> 
> for you to fetch changes up to 031a1a58513801a319f45f6ac1233605b13aefd2:
> 
>   ARM: sirf: add Atlas7 machine support (2015-01-14 21:09:24 +0800)

Since this contains the debug_ll changes, this branch needs to be rebased on
top of the respin.


-Olof
