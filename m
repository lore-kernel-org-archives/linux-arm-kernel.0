From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Sun, 3 Dec 2017 23:13:27 +0300
Subject: [PATCH 1/2] arm64: dts: orange-pi-zero-plus2: fix sdcard detect
In-Reply-To: <CAMty3ZDQqaiZ0RxtngWdX9PCW2+tzXLVB64heHLjRBeVF2-FCQ@mail.gmail.com>
References: <20171106122633.5mnqfh6xhmmxr45s@flea>
 <20171106161306.tq6yeq6bq36ridj3@speedy.hunter>
 <CAMty3ZCYQx0MfiJnOZPtO4nSAtOrGicOzw_x_AznTiEW8h2sLg@mail.gmail.com>
 <CAMty3ZANhL7cHqYw4VY2Sj_JUZGyqFZ+7pLssc1tniN3BdupOA@mail.gmail.com>
 <20171107201245.gptgfli54o6eqmrj@speedy.hunter>
 <CAMty3ZB3aXCsd9VkibjxPdA=BXvXr3nMbGJJvtZN_z2SGVUAXA@mail.gmail.com>
 <20171113192411.kmohcthzickk4n5v@speedy.hunter>
 <20171114143941.3qgdlqn4xfarfhql@flea.lan>
 <20171114185315.gwyacchfct4zvyif@speedy.hunter>
 <CAMty3ZDQqaiZ0RxtngWdX9PCW2+tzXLVB64heHLjRBeVF2-FCQ@mail.gmail.com>
Message-ID: <20171203201327.23ncp6goyxshiw4r@speedy.hunter>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maxime,

> >> > Do you plan to accept this patch as well ? Or you would prefer to wait
> >> > for the confirmation from Jagan as well ?
> >>
> >> I'm happy with the patch, but I was under the impression that the
> >> discussion had not settled yet. If it did, then yeah I'll merge it :)
> >
> > Both schematics and my tests on v1.0 board confirm that this fix is ok.
> > However we haven't yet got the ACK from Jagan, the original submitter
> > of this dts file. FWIW discussion was mostly about the problems with
> > his setup and not about the fix itself.
> >
> > Jagan,
> > did you have a chance to resolve the issues with your setup and verify
> > that boot from sd-card is fixed by this patch ?
> 
> Acked-by: Jagan Teki <jagan@openedev.com>

It looks like discussion has finally settled: here is ACK from Jagan.
Could you please take this patch.

Regards,
Sergey
