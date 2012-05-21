From: nm@ti.com (Menon, Nishanth)
Date: Mon, 21 May 2012 08:36:35 -0500
Subject: [PATCH V2] ARM: OMAP3+: PM: VP: ensure VP is idle before disable
In-Reply-To: <20120519095237.GA26761@besouro>
References: <1337365122-702-1-git-send-email-nm@ti.com>
 <20120519095237.GA26761@besouro>
Message-ID: <CAOMWX4f2N1dS8RcwYAyUpmWVKPkEHGuhMGGZ3__D-DwipsjzFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Sat, May 19, 2012 at 4:52 AM, Eduardo Valentin <eduardo.valentin@ti.com>
wrote:
>
>
> I guess it is time to properly document this increasing busy loop delay..
> As it is getting closer to ms scale..
Does the following sound good?
/* Maximum time for Voltage Processor to enter or exit idle */

Regards,
Nishanth Menon
