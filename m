From: carlo@caione.org (Carlo Caione)
Date: Wed, 2 Mar 2016 09:40:01 +0100
Subject: [PATCH v3] tty: serial: meson: Implement earlycon support
In-Reply-To: <1456886949-26503-1-git-send-email-afaerber@suse.de>
References: <1456886949-26503-1-git-send-email-afaerber@suse.de>
Message-ID: <CAOQ7t2a7-5qRDXZDGDpOCiwczHy-MmQcG0LH9GMKLMaXs98Sig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 2, 2016 at 3:49 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Split off the bulk of the existing meson_serial_console_write()
> implementation into meson_serial_port_write() for implementing
> meson_serial_early_console_write().
>
> Use "meson" as the earlycon driver name, courtesy of Nicolas.
>
> Signed-off-by: Nicolas Saenz Julienne <nicolassaenzj@gmail.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

Acked-by: Carlo Caione <carlo@endlessm.com>

Thanks,

-- 
Carlo Caione
