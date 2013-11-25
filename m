From: olof@lixom.net (Olof Johansson)
Date: Mon, 25 Nov 2013 09:39:22 -0800
Subject: [PATCH v4 REPOST] ARM: vexpress/TC2: Implement MCPM
 power_down_finish()
In-Reply-To: <1385396185-15291-1-git-send-email-Dave.Martin@arm.com>
References: <1385396185-15291-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <CAOesGMjcNhqUikHhP-Jx5cHUocHQUTPW9p5ikwwQxbMSFM7hvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Since v3.13-rc1, mcpm backends must implement an additional method which
> the vexpress TC2 implementation doesn't have upstream, resulting in an
> ugly WARN_ON() during hotplug and kexec operations

Please be more specific here. Which change in the 3.13 merge window caused this?


-Olof
