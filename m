From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Mar 2013 14:20:17 +0100
Subject: [PATCH 4/5] ARM: ux500: Supply a DTS file for the u8540 platform
In-Reply-To: <1363966065-2478-4-git-send-email-lee.jones@linaro.org>
References: <1363966065-2478-1-git-send-email-lee.jones@linaro.org>
 <1363966065-2478-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZovM_uqV3Bb-jxirJfda3PThST805X=htFhzN0pKEJNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 4:27 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This is a skeleton DTS file which only enables serial. Just using
> this simple file yields a terminal when booting u8540.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

There is a file for ccu9540.dts so please rename this
to ccu8540.dts for consistence.

(Apart from that it looks all right, a bit messy to see
which files belong to the ST-Ericsson platforms actually,
but I heard the dts folks are working on per-vendor subdirs
so lets wait for that.)

Yours,
Linus Wallei
