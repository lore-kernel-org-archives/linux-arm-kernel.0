From: peter.fordham@gmail.com (Peter Fordham)
Date: Tue, 24 Jul 2012 13:47:36 -0700
Subject: Corext A9 Errara 782773
Message-ID: <CAK5=ZRKrZt329o9fs41uNw16N1c3TZHZeJ+UGs+XVBaFaNuQTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm reviewing the errata notices from ARM for the rev 3 Cortex-A9
which we are using in a design (14 Jun 2012 issue). I'm not sure
whether this item should be of concern. I see no mention of it in the
archive of this mailing list or in the kernel tree:

"782773: Updating a translation entry to move a page mapping might
erroneously cause an unexpected translation fault."

I think it may require a workaround in the cpu_v7_set_pte_ext
function. Has anyone else looked into this?

thanks,

-Pete Fordham
