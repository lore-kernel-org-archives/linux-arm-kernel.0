From: B04825@freescale.com (Tabi Timur-B04825)
Date: Mon, 9 Jan 2012 23:26:38 +0000
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
Message-ID: <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 4:19 AM, Dave Martin <dave.martin@linaro.org> wrote:
>
> ? ? ?* edid -- It should be possible to have a fairly generic binding
> ? ? ? ?for EDID interfaces, but none seems to exist yet. ?Discussion
> ? ? ? ?is needed regarding what form this should take.
>
> ? ? ? ?This might more appropriately be called "ddc" (or some
> ? ? ? ?variation on that), since EDID seems only to describe the
> ? ? ? ?format of the ID data retrievable via this interface; not the
> ? ? ? ?interface itself.

Has there been any progress on this issue?  I'm looking to add EDID
support to a PowerPC device tree.  A TI developer is using
"ti,eeprom", but I'm not sure that's a good choice.

-- 
Timur Tabi
Linux kernel developer at Freescale
