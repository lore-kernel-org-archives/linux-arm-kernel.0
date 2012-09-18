From: javier.martin@vista-silicon.com (javier Martin)
Date: Tue, 18 Sep 2012 09:23:21 +0200
Subject: [PATCH 25/34] dma: imx-dma: remove mach/hardware.h inclusion
In-Reply-To: <CACKLOr0-s5Cuuun-sRvs=V3-J7wCjsKfDz8fVWxQGNbZEepDwQ@mail.gmail.com>
References: <CACKLOr0-s5Cuuun-sRvs=V3-J7wCjsKfDz8fVWxQGNbZEepDwQ@mail.gmail.com>
Message-ID: <CACKLOr244aYqmtQWXV=mP--pEuua7UswwpNrxwfN8GC5GhhQmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 17 September 2012 17:35, javier Martin
<javier.martin@vista-silicon.com> wrote:
> Hi,
> even after applying Sascha's fix I still get the following in our
> Visstrim SM10 board after testing this patch.

False alarm. With Sascha's fix it works properly. Don't forget to add
it to your series:

Tested-by: Javier Martin <javier.martin@vista-silicon.com>


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
