From: arunks.linux@gmail.com (Arun KS)
Date: Thu, 10 Jul 2014 14:16:41 +0530
Subject: Probe-defer and loading firmware
In-Reply-To: <CAKON4Oxa_jA1HH3aDH9NynszsPWe2as+XsYj1tFkVo-iwuTDnQ@mail.gmail.com>
References: <CAKON4Oxa_jA1HH3aDH9NynszsPWe2as+XsYj1tFkVo-iwuTDnQ@mail.gmail.com>
Message-ID: <CAKZGPAPT_YiEt1aPxAn90LcbKRpsJrjCmHd_HE7kdjayHht9BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

You can use request_firmware_nowait

Thanks,
Arun

On Sun, Jul 6, 2014 at 8:04 PM, jonsmirl at gmail.com <jonsmirl@gmail.com> wrote:
> I just tried building the Broadcom wifi driver into my kernel which
> didn't work.  The problem is that it needs to load firmware and the
> filesystem with the firmware on it hasn't been mounted yet.  The
> firmware is on my rootfs and I had rootwait on the kernel command
> line.
>
> Is it possible to get this to work? Shouldn't request-firmware do a
> probe-defer type operation until after rootwait completes?
>
> --
> Jon Smirl
> jonsmirl at gmail.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
