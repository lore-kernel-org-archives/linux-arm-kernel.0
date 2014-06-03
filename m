From: spk.linux@gmail.com (Sachin Kamat)
Date: Tue, 3 Jun 2014 16:57:28 +0530
Subject: [PATCH] serial: samsung: fix typo in debug code
In-Reply-To: <10455941.RzodM59Z3O@wuerfel>
References: <10455941.RzodM59Z3O@wuerfel>
Message-ID: <CAK5sBcH8YH1+i0yBUHLqiYWAmOV3v5Dpoavxo-ZOGA8oX0OcwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Jun 3, 2014 at 3:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> commit e4ac92df2791 ("serial: samsung: Neaten dbg uses") introduced
> a regression in the conversion from vsprintf to vsnprintf.
>
> This fixes the build error by passing the correct variable name.

I submitted a similar patch sometime back.
http://www.spinics.net/lists/linux-serial/msg12843.html

Regards,
Sachin
