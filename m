From: olof@lixom.net (Olof Johansson)
Date: Wed, 5 Sep 2012 10:42:40 -0700
Subject: [GIT PULL] ks8695 timer changes for v3.7
In-Reply-To: <CACRpkdbKJU9gp2MLKZQTGiyysoM38owyxJx8S2zFzRJiv61c5Q@mail.gmail.com>
References: <CACRpkdbKJU9gp2MLKZQTGiyysoM38owyxJx8S2zFzRJiv61c5Q@mail.gmail.com>
Message-ID: <20120905174240.GA24952@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 10:20:28AM +0200, Linus Walleij wrote:
> Hi Arnd, Olof:
> 
> Here is that patch series that switches KS8695 over to using generic
> time and clockevents. Signed tag provided.
> 
> All tested by Greg Ungerer.
> 
> Please pull it in!
> 
> The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:
> 
>   Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)
> 
> are available in the git repository at:
> 
>   http://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/ks8695-time-for-arm-soc

Thanks, pulled in as ks8695/timer into next/cleanup.

Btw, feel free to use git:// URLs in the future since the server
supports them.


-Olof
