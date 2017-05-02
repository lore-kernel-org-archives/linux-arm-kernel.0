From: jonas.gorski@gmail.com (Jonas Gorski)
Date: Tue, 2 May 2017 16:00:53 +0200
Subject: [RESEND PATCH] spi: bcm63xx-hsspi: Export OF device ID table as
 module aliases
In-Reply-To: <20170501201338.5368-1-andresgalacho@gmail.com>
References: <20170501201338.5368-1-andresgalacho@gmail.com>
Message-ID: <CAOiHx=mex7CDCP0dGtjdmENPx0oe2XexPLyF3DP=GPgUJXQT_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 May 2017 at 22:13, Andres Galacho <andresgalacho@gmail.com> wrote:
> The device table is required to load modules based on
> modaliases. After adding MODULE_DEVICE_TABLE, below entries
> for example will be added to module.alias:
> alias:          of:N*T*Cbrcm,bcm6328-hsspiC*
> alias:          of:N*T*Cbrcm,bcm6328-hsspi
>
> Signed-off-by: Andres Galacho <andresgalacho@gmail.com>

Not that it matters much with a trivial patch like this, but

Acked-by: Jonas Gorski <jonas.gorski@gmail.com>

also thanks for doing it.


Regards
Jonas
