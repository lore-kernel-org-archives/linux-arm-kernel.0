From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 4 Dec 2012 10:17:32 +0800
Subject: mx28: BUG: spinlock bad magic on CPU#0, swapper/0
In-Reply-To: <CAOMZO5CVy-+t7M-5aCUe3YhaWmP8bmFd=j0sEFw049KU7=jh+w@mail.gmail.com>
References: <CAOMZO5CVy-+t7M-5aCUe3YhaWmP8bmFd=j0sEFw049KU7=jh+w@mail.gmail.com>
Message-ID: <20121204021729.GA31562@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 03, 2012 at 03:43:53PM -0200, Fabio Estevam wrote:
> Hi,
> 
> I am getting the following warning on today's linux-next
> (3.7.0-rc7-next-20121203) running on a i.mx28:
> 
> [    0.076125] BUG: spinlock bad magic on CPU#0, swapper/0
...
> 
> Is it a known issue?
> 
It looks like a new issue.  Care to run a git bisect?

Shawn
