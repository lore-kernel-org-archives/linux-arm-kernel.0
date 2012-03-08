From: olof@lixom.net (Olof Johansson)
Date: Thu, 8 Mar 2012 08:59:33 -0800
Subject: [PATCH] ARM: S3C2440: Fixed build error for s3c244x
In-Reply-To: <1331200116-2424-1-git-send-email-kgene.kim@samsung.com>
References: <1331200116-2424-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <CAOesGMhkZLGRYi3QTko0gcbj3MJ4vZE6mddEFLFsMhdx9fkx9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 8, 2012 at 1:48 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Fixed following:
> arch/arm/mach-s3c2440/s3c244x.c: In function 's3c244x_restart':
> arch/arm/mach-s3c2440/s3c244x.c:209: error: expected declaration or statement at end of input
> make[1]: *** [arch/arm/mach-s3c24xx/s3c244x.o] Error 1
> make: *** [arch/arm/mach-s3c24xx] Error 2
>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks, applied to fixes and I'll send out a pull request for the branch today.


-Olof
