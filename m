From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Aug 2017 12:53:26 +0200
Subject: [PATCH 07/14] asm-generic: add kexec_file_load system call to
 unistd.h
In-Reply-To: <20170824081811.19299-8-takahiro.akashi@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-8-takahiro.akashi@linaro.org>
Message-ID: <CAK8P3a3gieZhSS5Qz4UeEP2TENV8j0897qYC3Dbn6jR8h7SUNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 10:18 AM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> The initial user of this system call number is arm64.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by:Arnd Bergmann <arnd@arndb.de>
