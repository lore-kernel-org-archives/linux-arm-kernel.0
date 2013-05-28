From: olof@lixom.net (Olof Johansson)
Date: Mon, 27 May 2013 20:13:20 -0700
Subject: [GIT PULL] ux500 DMA40 device tree migration base
In-Reply-To: <CACRpkdZjr=48_GJxsoYgK7DFUqLs10x4o9yky3MzNR7vh24ogA@mail.gmail.com>
References: <CACRpkdZjr=48_GJxsoYgK7DFUqLs10x4o9yky3MzNR7vh24ogA@mail.gmail.com>
Message-ID: <20130528031320.GD13532@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 09:34:22PM +0200, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> here is a patch set that Lee has been chiseling out recently. I've
> accumulated it in my ux500 tree and piled ACKs on the first 36
> patches of the patch set. Basically that includes ACKs from
> subsystem maintainers Vinod Koul and Herbert Xu for affected
> parts.
> 
> We need to get this into Linux-next to proceed with further
> migration on top of it. All have been circulated on the lists for
> a while.
> 
> Please pull this into an apropriate ARM SoC branch for v3.11!
> 
> If we can get ACKs for the rest of the patches in Lee's set these
> will arrive on top of this base as soon as they are ready.
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:
> 
>   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/ux500-dma40-for-arm-soc

Thanks, pulled into next/drivers.

I see the conversions have been made the brute-force way instead of keeping
backwards compatibility and cleaning up drivers before removing no longer
needed board code. That should be fine, as long as you don't introduce too
crazy dependencies (and conflicts) in the code you're talking about adding on
top. 


-Olof
