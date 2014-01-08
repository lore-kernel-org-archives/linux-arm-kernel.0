From: pmeerw@pmeerw.net (Peter Meerwald)
Date: Wed, 8 Jan 2014 13:50:02 +0100 (CET)
Subject: Information about Atmel MXT224
In-Reply-To: <52CD4376.50305@gmail.com>
References: <52CD04F1.8090100@gmail.com>
 <alpine.DEB.2.01.1401081228580.1454@pmeerw.net> <52CD4376.50305@gmail.com>
Message-ID: <alpine.DEB.2.01.1401081344451.1454@pmeerw.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> I am in Belgium and we deal with Gleichmann & Co. Electronics in Germany to
> have their devkit (SMT-C-T10). I have signed a NDA with them to have MXT224
> protocol guide but they never send me Protocol Guide.
> I will try another distributor.

just ask harder; I got it from them
 
> > something goes wrong in the initialization; the object table of the
> > chip doesn't match the register data fed in -- the mxt224 can be a bitch
> > and play dead
 
> So what can I do ? Maybe a problem with the embedded firmware that need an
> update (atmel_mxt_ts 0-004b: Family ID: 129 Variant ID: 1 Major.Minor.Build:
> 2.0.AB)

you need to understand the object table and see what object leads to the 
invalid object message; there is some mismatch between the driver and the 
chip

> When I do cat /proc/interrupts and I short-circuit /CHG to ground, number
> increases so low-level handling of interrupt is working.

if I remember correctly, the mxt224 does periodic interrupts (200ms?) 
when something is wrong with the config

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
