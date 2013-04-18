From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Thu, 18 Apr 2013 11:26:10 -0300
Subject: AT91SAM9M10: Problem porting driver for MT9P031 sensor
In-Reply-To: <CD957E83.AF12%marcio@netopen.com.br>
References: <2001207140.384354.1366290836027.open-xchange@email.1und1.de>
 <CD957E83.AF12%marcio@netopen.com.br>
Message-ID: <CALF0-+UxFVOeMCEXaw3fUL2_NU=19+hXh3Ad8V9DVAUNtaSWtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcio,

On Thu, Apr 18, 2013 at 9:47 AM, Marcio Campos de Lima
<marcio@netopen.com.br> wrote:
>
> I am porting the MT9P031 sensor device driver for a custom designed board
> based at the AT91SAM9M45-EK development board and Linux 3.6.9.
> The driver detects the sensor but does not create /dev/video1. I cannot
> even see /dev/video0 that usually is created by default.
>

You might get better luck if you push your code somewhere
so people can take a look at it.

Also, IMHO the arm mailing list is not the best place to ask
try asking the media ML: linux-media _at_ vger.kernel.org
and #v4l at freenode IRC.

Good luck!
-- 
    Ezequiel
