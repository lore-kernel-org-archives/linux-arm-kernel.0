From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 5 Sep 2012 16:07:08 -0300
Subject: [PATCH] ARM : i.MX27 : split code for allocation of ressources of
 camera and eMMA
In-Reply-To: <50479F1E.9060403@gmail.com>
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
 <50479F1E.9060403@gmail.com>
Message-ID: <CAOMZO5BoY57iyzFgsU2x_g4spDVpFG4viy1ePHAsHL+afwoOCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 5, 2012 at 3:51 PM, Ga?tan Carlier <gcembed@gmail.com> wrote:

> This is maybe related to the problem that I have already noticed here :
> http://mailman.alsa-project.org/pipermail/alsa-devel/2012-August/054594.html
> If MMC is disabled, Sound and coda (not sure anymore, I will check it
> tomorrow) don't work correctly.

Yes, just reproduced the same here: deselected mmc driver and now
audio does not work.

We need to review the mx27 clock tree.

Regards,

Fabio Estevam
