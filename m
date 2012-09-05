From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 5 Sep 2012 12:29:56 -0300
Subject: [PATCH] ARM : i.MX27 : split code for allocation of ressources of
 camera and eMMA
In-Reply-To: <504769CF.2070904@gmail.com>
References: <1346763398-13536-1-git-send-email-gcembed@gmail.com>
 <CACKLOr0PO1jbxrfRoEwEAGFNkNkAFUA-oB2vLZpw1kDxEYPBQw@mail.gmail.com>
 <5047013E.30508@gmail.com>
 <CACKLOr1RipM3QVJBaTjXHFotqSMdrCsWLkBsgiiuauTWpxR6EQ@mail.gmail.com>
 <50471187.3040809@gmail.com>
 <CACKLOr0=TccMNoQV-LfkeBrCN5=0E8eqTEaT7PRk-KAv_mQ5RQ@mail.gmail.com>
 <50471CEE.60606@gmail.com>
 <CAOMZO5D7DrUwg1YYwPnXgMj4nsgS=2ctnb7J3n-60hkreoP3yw@mail.gmail.com>
 <504769CF.2070904@gmail.com>
Message-ID: <CAOMZO5DyjdrZYNDMuT1=yuxQcHuP3=6dy_j_ja1vub56_m3pvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 5, 2012 at 12:03 PM, Ga?tan Carlier <gcembed@gmail.com> wrote:

> With or without my patch ? I have burnt out my ov2640 while previous

Without your patch. Just running a clean linux-next-20120905.

> experimentation so it is hard for me to test that and I have to write driver
> for MT9V111 to be able to test soc-camera on Kernel 3.x.

Write a driver? There is already one: drivers/media/i2c/mt9v011.c

Regards,

Fabio Estevam
