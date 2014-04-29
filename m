From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 29 Apr 2014 09:21:43 +0200
Subject: [PATCH v4 05/11] ARM: shmobile: r7s72100: genmai: add uart
 aliases and activate scif2 as console
In-Reply-To: <CANqRtoTHy+-ac0kWY5a9MdYN0=jwWdeuOus9CVBckmas32_hSQ@mail.gmail.com>
References: <1398704521-23767-1-git-send-email-wsa@the-dreams.de>
 <1398704521-23767-6-git-send-email-wsa@the-dreams.de>
 <CANqRtoTHy+-ac0kWY5a9MdYN0=jwWdeuOus9CVBckmas32_hSQ@mail.gmail.com>
Message-ID: <20140429072143.GA2732@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

> Thanks for your updated series. For this patch I only have a minor
> comment. I believe we only want to enable the serial port that is used
> on the board. At the same time we want to keep the same ordering as
> the legacy code. I believe you keep the same order already and only
> enable ttySC2, but I wonder if you really need all the aliases above?
> Perhaps it is possible to keep just serial2?

Yeah, this is easily possible. I wanted to add the additional aliases
because the other SCIF pins are available on the external connectors and
wanted potential users to save some hassle. Let me know if you think
this is not needed and I will resend this patch only taking care of
SCIF2.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140429/22a4b582/attachment-0001.sig>
