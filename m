From: olof@lixom.net (Olof Johansson)
Date: Sat, 17 Dec 2011 20:22:37 -0800
Subject: [PATCH v4 2/5] ARM: SMP: Refactor Kconfig to be more maintainable
In-Reply-To: <1323798993-8727-3-git-send-email-dave.martin@linaro.org>
References: <1323798993-8727-1-git-send-email-dave.martin@linaro.org>
 <1323798993-8727-3-git-send-email-dave.martin@linaro.org>
Message-ID: <CAOesGMhiBiBaFnEM7a3DnKPChOWSD+e+tWDZU-1zLRtaBLvs4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 9:56 AM, Dave Martin <dave.martin@linaro.org> wrote:
> Making SMP depend on (huge list of MACH_ and ARCH_ configs) is
> bothersome to maintain and likely to lead to merge conflicts.
>
> This patch moves the knowledge of which platforms are SMP-capable
> to the individual machines. ?To enable this, a new HAVE_SMP config
> option is introduced to allow machines to indicate that they can
> run in a SMP configuration.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Olof Johansson <olof@lixom.net>  (Tegra parts)

Thanks for doing this, I've been itching over it as well but never got
around to fixing it.


-Olof
