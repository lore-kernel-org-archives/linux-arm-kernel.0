From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 29 Mar 2016 10:29:25 +0200
Subject: [PATCH resend 0/4] of_touchscreen-helpers: Add support for inverted /
 swapped axis
Message-ID: <1459240169-11531-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

It seems that this series has fallen through the cracks *again*.

This is a resend of the resend of this set posted a while back, now rebased
on top of v4.6-rc1.

Last time one remark you made was:

+#include <asm/types.h>

> If you are trying to add this to have s32 typedefs
> then I think it is wrong one.

I've double checked and I believe it is the right one,
s32 is typedef-ed in <asm-generic/int-ll64.h> but no-one is including that
directly.

Regards,

Hans
