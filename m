From: alban.browaeys@gmail.com (Alban Browaeys)
Date: Fri, 16 Sep 2016 15:35:50 +0200
Subject: genirq: Setting trigger mode 0 for irq 11 failed
 (txx9_irq_set_type+0x0/0xb8)
In-Reply-To: <57DBEBC8.7000209@arm.com>
References: <CAMuHMdVW1eTn20=EtYcJ8hkVwohaSuH_yQXrY2MGBEvZ8fpFOg@mail.gmail.com>
 <1473980577.17787.21.camel@gmail.com> <57DBA464.9010506@arm.com>
 <1474023805.17258.10.camel@gmail.com> <57DBEBC8.7000209@arm.com>
Message-ID: <1474032950.9425.12.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le vendredi 16 septembre 2016 ? 13:55 +0100, Marc Zyngier a ?crit?:
> At that stage, I'm not sure I should care. Does the workaround make
> your
> platform usable?

However awkward this was all about logs and clearing worries. There was
no change in behavior ?between the three cases : upstream, upstream
commit reverted and patched upstream.

Mind this hardware (the Odroid U2) has no hardware buttons. Only power
on plug.

Best regards,
Alban
