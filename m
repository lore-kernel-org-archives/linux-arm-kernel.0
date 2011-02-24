From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 24 Feb 2011 11:06:47 +0000
Subject: [PATCH v2] ARM: Thumb-2: Reflect ARM/Thumb-2 configuration in
	module vermagic
In-Reply-To: <4D657B12.8070702@ru.mvista.com>
References: <1298462021-22177-1-git-send-email-dave.martin@linaro.org>
	<4D657B12.8070702@ru.mvista.com>
Message-ID: <AANLkTimm+xqrQSWzPxxV7Kv+0NH2fpkg2HHUz=JNj3pN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23, 2011 at 9:24 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> On 23-02-2011 14:53, Dave Martin wrote:
>
>> Loading Thumb-2 modules into an ARM kernel or vice-versa isn't
>> guaranteed to work safely, since the kernel is not interworking-
>> aware everywhere.
>
>> This patch adds "thumb2" to the module vermagic when
>> CONFIG_THUMB2_KERNEL is enabled, to help avoid accidental loading
>> of modules into the wrong kernel.
>
>> v2: modified to apply consistently on top of rmk's p2v branch.
>
> ? Patch changelog should follow the -- tearline.
>
>> Signed-off-by: Dave Martin<dave.martin@linaro.org>
>> Acked-by: Nicolas Pitre<nicolas.pitre@linaro.org>
>
> WBR, Sergei
>

Opinions seem to differ... I have no strong opinion on this myself.

Cheers
---Dave
