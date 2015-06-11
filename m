From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 11 Jun 2015 14:19:54 -0700
Subject: [PATCH] ARM64: add GPIO keys to the defconfig
In-Reply-To: <55705BF8.7010904@linaro.org> (Shannon Zhao's message of "Thu, 04
 Jun 2015 22:08:56 +0800")
References: <1433418101-10367-1-git-send-email-linus.walleij@linaro.org>
 <55705BF8.7010904@linaro.org>
Message-ID: <7hd212djt1.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shannon Zhao <shannon.zhao@linaro.org> writes:

> On 2015/6/4 19:41, Linus Walleij wrote:
>> The Juno board, and likely many other boards, likes to use simple
>> GPIO keys for input events. Enabled this in the default
>> ARM64 defconfig.
>>
>
> This is also useful for QEMU to support external poweroff on ARM.
>
> Reviewed-by: Shannon Zhao <shannon.zhao@linaro.org>
>

Applied to next/defconfig with Shannon's ack.

Kevin
