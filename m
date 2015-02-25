From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 25 Feb 2015 20:59:53 +0800
Subject: [Linaro-acpi] [PATCH v3 3/9] ACPI: clean up checkpatch warnings
 for various bits of syntax
In-Reply-To: <1424824585-6405-4-git-send-email-al.stone@linaro.org>
References: <1424824585-6405-1-git-send-email-al.stone@linaro.org>
 <1424824585-6405-4-git-send-email-al.stone@linaro.org>
Message-ID: <54EDC749.8080200@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?02?25? 08:36, al.stone at linaro.org wrote:
> From: Al Stone<al.stone@linaro.org>
>
> In preparation for later splitting out some of the arch-dependent code from
> osl.c, clean up a bunch of warnings for odd bits of syntax:
>
>     -- remove CVS keyword markers
>     -- remove a space from between a function name and an opening parenthesis
>     -- clean up all but one line > 80 characters (one just looks silly if you
>        make it less than 80)
>     -- add blank lines after declarations in functions
>     -- remove extraneous braces ({})
>
> Signed-off-by: Al Stone<al.stone@linaro.org>

Reviewd-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
