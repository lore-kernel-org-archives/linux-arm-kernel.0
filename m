From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Thu, 29 Jan 2015 17:39:49 +0100
Subject: [PATCH] spi/xilinx: Cast ioread32/iowrite32 function pointers
In-Reply-To: <1597235.QjzCE74z4V@wuerfel>
References: <1422543073-21895-1-git-send-email-ricardo.ribalda@gmail.com>
 <1597235.QjzCE74z4V@wuerfel>
Message-ID: <CAPybu_12uVvA8pNsiRqn3tc04wDwxnMFUjKPqHNt2NyhT62uwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd

On Thu, Jan 29, 2015 at 5:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Casting the type of a function you call seems rather dangerous. Why not
> add an inline function in this driver as a wrapper?
>
>         Arnd

Agree, please ignore this patch. Sorry for the noise


-- 
Ricardo Ribalda
