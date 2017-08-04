From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 Aug 2017 12:58:41 +0200
Subject: [PATCH v2] bus: uniphier-system-bus: set up registers when
 resuming
In-Reply-To: <1501480165-10527-1-git-send-email-yamada.masahiro@socionext.com>
References: <1501480165-10527-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK8P3a05scVFb_0BLfnzwXDSsrbAKxrZyrSddcWkmDBtpUW0jQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 7:49 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> When resuming, set up registers that have been lost in the sleep state.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to fixes. I assume you want this in 4.13, but not backported
to stable kernels.
If that is incorrect, please let me know. Ideally that information
should be in the email
though, after the --- line.

Thanks,

       Arnd
