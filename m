From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 27 Jul 2014 13:50:35 +0300
Subject: [PATCH 1/2] hwspinlock/omap: enable module before reading
 SYSSTATUS register
In-Reply-To: <53D122A1.4040204@ti.com>
References: <1404342060-2919-1-git-send-email-s-anna@ti.com>
 <1404342060-2919-2-git-send-email-s-anna@ti.com>
 <CAK=Wgba3OOgZG_smj5=raE+ZXZ-F0ksn4pcGeDc1JDE34Q-wFg@mail.gmail.com>
 <53D122A1.4040204@ti.com>
Message-ID: <CAK=WgbbthPvZ5exv9tTc5hTpFgM6sd0BHWkqRpZqJp8-9Am9uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 6:13 PM, Suman Anna <s-anna@ti.com> wrote:
>> Is there a specific reason for using the put_sync variant here? If
>> not, let's just use the regular put().
>
> There was no particular reason, you can change it.

Thanks for confirming. I've applied both patches to remoteproc's
for-next branch.

Thanks,
Ohad.
