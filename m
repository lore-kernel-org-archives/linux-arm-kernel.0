From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Dec 2014 15:49:27 -0800
Subject: [PATCH v2] arm64: Enable CONFIG_COMPAT also for 64k page size
In-Reply-To: <1417736899-115619-1-git-send-email-agraf@suse.de>
References: <1417736899-115619-1-git-send-email-agraf@suse.de>
Message-ID: <CAOesGMgATgU6TnrGvr2OH+x7R750bQ7X02WGL5Sqc1F2vhvZHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 4, 2014 at 3:48 PM, Alexander Graf <agraf@suse.de> wrote:
> With binutils 2.25 the default alignment for 32bit arm sections changed to
> have everything 64k aligned. Armv7 binaries built with this binutils version
> run successfully on an arm64 system.
>
> Since effectively there is now the chance to run armv7 code on arm64 even
> with 64k page size, it doesn't make sense to block people from enabling
> CONFIG_COMPAT on those configurations.
>
> Signed-off-by: Alexander Graf <agraf@suse.de>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
