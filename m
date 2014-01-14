From: wd@denx.de (Wolfgang Denk)
Date: Tue, 14 Jan 2014 19:53:02 +0100
Subject: AArch64 kernel image decompression
In-Reply-To: <CAOesGMj0HPWD=Mavt1ut+Oze4KQZHjhHmcKTcdKELaF=Or8XsA@mail.gmail.com>
References: <20140110170436.GS8153@joshc.qualcomm.com>
 <69dfcb9d142443638e4ccfedd92c4f05@BN1PR03MB220.namprd03.prod.outlook.com>
 <4250104.UfkPP3heXI@wuerfel> <201401141351.18988.marex@denx.de>
 <819346bb83b04348a266643afd5bd6f6@BN1PR03MB220.namprd03.prod.outlook.com>
 <20140114134732.F0A1C3821F2@gemini.denx.de>
 <CAOesGMj0HPWD=Mavt1ut+Oze4KQZHjhHmcKTcdKELaF=Or8XsA@mail.gmail.com>
Message-ID: <20140114185302.0B0813821F2@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Olof,

In message <CAOesGMj0HPWD=Mavt1ut+Oze4KQZHjhHmcKTcdKELaF=Or8XsA@mail.gmail.com> you wrote:
>
> > The FIT image approach as suggested by Marek also allows for secure
> > boot methods (like cryptographically signed images); this is used in
> > production for several systems, including the Google Chromebook.
> 
> This can very easily be misunderstood so I would like to clarify:
> Chromebooks do not use the fitImage version of signatures and
> verification, it is done independently from a separate library that
> wraps either a zImage (x86) or a fitImage (ARM).

This is not what I'm talking about.  What I mean is the support for
Verified Boot (see [1]) and FIT Signature Verification (see [2]) which
is done with plain FIT images, without additional wrapping.

[1] http://git.denx.de/?p=u-boot.git;a=blob;f=doc/uImage.FIT/verified-boot.txt
[2] http://git.denx.de/?p=u-boot.git;a=blob;f=doc/uImage.FIT/signature.txt

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
Don't hit a man when he's down - kick him; it's easier.
