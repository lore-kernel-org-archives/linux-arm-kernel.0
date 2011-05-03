From: camhirundo@gmail.com (Hirundo Cam)
Date: Tue, 3 May 2011 23:55:39 +0800
Subject: [PATCH] kirkwood: add dir-665 support
In-Reply-To: <1303922086-10531-1-git-send-email-camhirundo@gmail.com>
References: <1303922086-10531-1-git-send-email-camhirundo@gmail.com>
Message-ID: <BANLkTimL8yKk3UfA1_2nuDaJFahEDGLFdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi  Robin, Nicolas, and Mike

2011/4/28 Hirundo Cam <camhirundo@gmail.com>:
> This patch is a hack to dir-665 by referencing mv88f6281gtw_ge board.
> LEDs, GPIO, Buttons remains unknown.
>
> To use this patch, u-boot must also be modified.
>
> Signed-off-by: Hirundo Cam <camhirundo@gmail.com>
> ---
> ?arch/arm/mach-kirkwood/Kconfig ? ? ? ? ? ?| ? ?6 ++
> ?arch/arm/mach-kirkwood/Makefile ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-kirkwood/mv88f6281_dir665.c | ?107 +++++++++++++++++++++++++++++
> ?arch/arm/tools/mach-types ? ? ? ? ? ? ? ? | ? ?1 +
> ?4 files changed, 115 insertions(+), 0 deletions(-)

I'm new to arm-linux mailing list. Since I have done a hack to DIR-665
which uses mv88f6281_A1 (kirkwood), then I'm willing to send a patch to kernel.

I've found you have commit kirkwood related patches in to kernel.
Would you help on review this patch?
Thanks.

regards,
Hirundo Cam.
