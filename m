From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 25 Feb 2015 20:47:53 +0800
Subject: [PATCH v3 1/9] ACPI: fix all errors reported by cleanpatch.pl
 in osl.c
In-Reply-To: <1424824585-6405-2-git-send-email-al.stone@linaro.org>
References: <1424824585-6405-1-git-send-email-al.stone@linaro.org>
 <1424824585-6405-2-git-send-email-al.stone@linaro.org>
Message-ID: <54EDC479.4000603@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?02?25? 08:36, al.stone at linaro.org wrote:
> From: Al Stone <al.stone@linaro.org>
>
> In preparation for later splitting out some of the arch-dependent code from
> osl.c, clean up the errors reported by checkpatch.pl.  They fell into these
> classes:
>
>     -- remove the FSF address from the GPL notice
>     -- "foo * bar" should be "foo *bar" (and the ** variation of same)
>     -- a return is not a function, so parentheses are not required.
>
> Signed-off-by: Al Stone <al.stone@linaro.org>

Reviewd-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
