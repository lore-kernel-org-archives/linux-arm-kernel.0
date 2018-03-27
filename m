From: kvalo@codeaurora.org (Kalle Valo)
Date: Tue, 27 Mar 2018 08:02:04 +0000 (UTC)
Subject: [2/4] wireless: Use octal not symbolic permissions
In-Reply-To: <a368e1c4878619172f3da4849cb211b4dfad0a58.1521845237.git.joe@perches.com>
References: <a368e1c4878619172f3da4849cb211b4dfad0a58.1521845237.git.joe@perches.com>
Message-ID: <20180327080205.07AD26030F@smtp.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joe Perches <joe@perches.com> wrote:

> Prefer the direct use of octal for permissions.
> 
> Done with checkpatch -f --types=SYMBOLIC_PERMS --fix-inplace
> and some typing.
> 
> Miscellanea:
> 
> o Whitespace neatening around these conversions.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Patch applied to wireless-drivers-next.git, thanks.

2ef00c53049b wireless: Use octal not symbolic permissions

-- 
https://patchwork.kernel.org/patch/10305719/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
