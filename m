From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 30 Dec 2013 10:39:59 +0530
Subject: [PATCH 1/1] arm: Trivial cleanup in sp810.h
In-Reply-To: <1388379897-30548-1-git-send-email-sachin.kamat@linaro.org>
References: <1388379897-30548-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CAKohpomRh4kB5_tU8Qw88-KFXvjTbZXhdD918r92qhwMMBA4Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 December 2013 10:34, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Commit da660b4a3b15 ("arm: Move sp810.h to include/linux/amba/")
> moved the file to the current location but forgot to remove the pointer
> to its previous location. Clean it up. While at it also change the header
> file protection macros appropriately.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  include/linux/amba/sp810.h |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
