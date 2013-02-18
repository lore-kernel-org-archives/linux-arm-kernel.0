From: olof@lixom.net (Olof Johansson)
Date: Sun, 17 Feb 2013 16:50:49 -0800
Subject: [GIT PULL] at91: more DT changes related to MTD for 3.9
In-Reply-To: <511B78C5.5030209@atmel.com>
References: <511B78C5.5030209@atmel.com>
Message-ID: <20130218005049.GD4615@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 12:28:05PM +0100, Nicolas Ferre wrote:
> Hi Olof, Arnd,
> 
> I would like you to consider this little pull request for modification of some
> AT91 Device Tree files.
> We have had a discussion about this material earlier and now that Artem has queued
> the driver modifications for MTD, I would like to know if it is possible to
> add these two patches in your late/dt branch?

Note that unless you break existing bindings (which you should never, or very
very rarely do), adding the new contents doesn't have to wait for the driver
changes. As long as the bindings are settled, the DT changes can go in.

> The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:
> 
>   Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)
> 
> are available in the git repository at:
> 
>   git://github.com/at91linux/linux-at91.git tags/at91-dt-late

Pulled, thanks.


-Olof
