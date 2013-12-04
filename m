From: olof@lixom.net (Olof Johansson)
Date: Tue, 3 Dec 2013 16:48:33 -0800
Subject: [GIT PULL] ux500 devicetree changes for v3.14, take one
In-Reply-To: <CACRpkdZKZdQ08MnDL94f3DwdE1CYbdcHSYwNKwgqr3AhYqE_mg@mail.gmail.com>
References: <CACRpkdZKZdQ08MnDL94f3DwdE1CYbdcHSYwNKwgqr3AhYqE_mg@mail.gmail.com>
Message-ID: <20131204004833.GC18383@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 09:32:43PM +0100, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> as you know we discontinued ATAG booting for the ux500 platforms
> in the v3.13 merge window.
> 
> Now we can start to move things over to device tree exclusively and
> get rid of board files, especially AUXDATA.
> 
> In some ACKed cases we even get rid of the non-DT boot path in
> individual drivers.
> 
> Please have a look at this nice diffstat and pull in for v3.14 if you are
> satisfied with the end result.
> 
> Yours,
> Linus Walleij
> 
> 
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> 
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/ux500-devicetree-v3.14-1

Pulled, thanks!


-Olof
