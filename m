From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 May 2014 12:40:56 -0700
Subject: [PATCH] arm: scoop: Remove unused variable
In-Reply-To: <1396962535-6249-1-git-send-email-fabio.estevam@freescale.com>
References: <1396962535-6249-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <CAOesGMgkCSnPLoQn=b9Stf0mJG6b8ryDGgrOGKmsXApKHbz0CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 8, 2014 at 6:08 AM, Fabio Estevam
<fabio.estevam@freescale.com> wrote:
> Remove the 'temp' variable in order to fix the following build warning:
>
> arch/arm/common/scoop.c:185:6: warning: unused variable 'temp' [-Wunused-variable]
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Olof Johansson <olof@lixom.net>

Can you forward to Russell's patch tracker, please?


Thanks,

-Olof
