From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 11 Feb 2011 17:15:07 +0300
Subject: [PATCH] arm: update gitignore file
In-Reply-To: <1297387616-29390-1-git-send-email-rklein@nvidia.com>
References: <1297387616-29390-1-git-send-email-rklein@nvidia.com>
Message-ID: <4D55446B.4030605@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11-02-2011 4:26, rklein at nvidia.com wrote:

> From: Rhyland Klein<rklein@nvidia.com>

> Updating the .gitignore file to ignore 3 files that are always created in
> manual builds to cleanup git status results.

> Signed-off-by: Rhyland Klein<rklein@nvidia.com>
> ---
>   arch/arm/boot/compressed/.gitignore |    3 +++
>   1 files changed, 3 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
> index ab204db..c52a6dd 100644
> --- a/arch/arm/boot/compressed/.gitignore
> +++ b/arch/arm/boot/compressed/.gitignore
> @@ -1,3 +1,6 @@
>   font.c
>   piggy.gz
>   vmlinux.lds
> +lib1funcs.S
> +piggy.gzip
> +vmlinux

    Similar patch has already been submitted several times by Sergio Aguirre...

WBR, Sergei
