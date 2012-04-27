From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 27 Apr 2012 13:06:04 +0800
Subject: [PATCH] arch/arm: mioa701 add camera output enable gpio
In-Reply-To: <1335129840-25387-1-git-send-email-robert.jarzmik@free.fr>
References: <1335129840-25387-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <CAN1soZyOZPTR=4Q14yq8ngZ=mwG8R7rO=NSxqnDk1HZMz9uWNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 5:24 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> The Micron MT9M111 camera chip needs its output enable to be
> activated in order to work. The bootloader is not required to
> activate it, so do it in machine code.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> ?arch/arm/mach-pxa/include/mach/mioa701.h | ? ?3 +++
> ?arch/arm/mach-pxa/mioa701.c ? ? ? ? ? ? ?| ? ?2 ++
> ?2 files changed, 5 insertions(+), 0 deletions(-)
>
Applied

Regards
Haojian
