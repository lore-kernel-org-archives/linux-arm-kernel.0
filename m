From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 2 Feb 2017 15:45:05 +0800
Subject: [PATCH 09/33] Input: sun4i-lradc-keys - Drop unnecessary call to
 platform_set_drvdata and other changes
In-Reply-To: <1484761614-12225-10-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484761614-12225-10-git-send-email-linux@roeck-us.net>
Message-ID: <CAGb2v66xRG7ubPqjTEzUk=fRY0h6MKK-UFePpbBE7nLiK7qaoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 1:46 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> There is no call to platform_get_drvdata() or dev_get_drvdata().
> Drop the unnecessary call to platform_set_drvdata().
> Other relevant changes:
>   Simplify error return
>
> This conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>
> - Replace 'if (e) return e; return 0;' with 'return e;'
> - Drop platform_set_drvdata()
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Chen-Yu Tsai <wens@csie.org>
