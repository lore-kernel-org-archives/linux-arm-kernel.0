From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 15 Feb 2018 11:44:24 +0100
Subject: [PATCH] ARM: shmobile: stout: enable R-Car Gen2 regulator quirk
In-Reply-To: <15de7079-f43e-1e76-2a99-7232498b077a@gmail.com>
References: <20180213232812.31408-1-marek.vasut+renesas@gmail.com>
 <20180214055800.od5yhgo753522yah@katana>
 <CAMuHMdU3opUTcOY-UeH4ArB+50_drPhGSoxP-m85p9V36fvTHg@mail.gmail.com>
 <ae3206a3-4735-87c8-9688-3acdbf06cc36@gmail.com>
 <CAMuHMdU4_wVcKwjB1ZQzfgp8vCDs92F1o+v4UyZ0bsRDfJD1vQ@mail.gmail.com>
 <15de7079-f43e-1e76-2a99-7232498b077a@gmail.com>
Message-ID: <20180215104423.jj5msnd2evajzwpw@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > BTW, several PPC platforms use of_device_compatible_match(of_root, ...),
> > but I believe of_root is not guaranteed to be set up.
> 
> OK, subsequent patch then. Added to TODO.

Can you place it below the PCIE patches, please? ;)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180215/f8a717f5/attachment-0001.sig>
