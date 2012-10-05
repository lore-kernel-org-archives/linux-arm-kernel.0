From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 5 Oct 2012 18:55:36 -0300
Subject: [PATCH] ARM : i.MX27 : split code for allocation of ressources of
 camera and eMMA
In-Reply-To: <CACKLOr1W4PoVUqJ+KEcE1yUOhcRJDR6RDm_Mn=GhQxkfPg-5mQ@mail.gmail.com>
References: <1346763398-13536-1-git-send-email-gcembed@gmail.com>
 <CACKLOr0PO1jbxrfRoEwEAGFNkNkAFUA-oB2vLZpw1kDxEYPBQw@mail.gmail.com>
 <5047013E.30508@gmail.com>
 <CACKLOr1RipM3QVJBaTjXHFotqSMdrCsWLkBsgiiuauTWpxR6EQ@mail.gmail.com>
 <50471187.3040809@gmail.com>
 <CACKLOr0=TccMNoQV-LfkeBrCN5=0E8eqTEaT7PRk-KAv_mQ5RQ@mail.gmail.com>
 <50471CEE.60606@gmail.com>
 <CAOMZO5D7DrUwg1YYwPnXgMj4nsgS=2ctnb7J3n-60hkreoP3yw@mail.gmail.com>
 <504769CF.2070904@gmail.com>
 <CAOMZO5DyjdrZYNDMuT1=yuxQcHuP3=6dy_j_ja1vub56_m3pvA@mail.gmail.com>
 <504774B7.8090007@gmail.com>
 <CAOMZO5CAvwwGEwbZE2VS49tpWOYxAR_qQkfKhswPaofSrni92A@mail.gmail.com>
 <CAOMZO5C+NNQr0mo6P2cKx4RxFoQPyYuPZq4eFUZnvi_7gTRkBQ@mail.gmail.com>
 <CACKLOr1W4PoVUqJ+KEcE1yUOhcRJDR6RDm_Mn=GhQxkfPg-5mQ@mail.gmail.com>
Message-ID: <CAOMZO5Bh4PGE3fAJytaD4i2hqD2NDDrwETs=PzLPno_hs-5ryw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Fri, Oct 5, 2012 at 3:51 AM, javier Martin
<javier.martin@vista-silicon.com> wrote:

> No, it isn't. Kernel 3.6 works properly in our Visstrim M10 board and
> the CSI clock frequency is the same as yours:

I managed to fix it. Now the CSI clock is the same as in 3.4 kernel
and ov2640 probes successfully.

Just submitted the patches.

Regards,

Fabio Estevam
