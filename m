From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 24 Oct 2016 12:17:00 +0200
Subject: [PATCH] mfd: axp20x-i2c: Add i2c-ids to fix module auto-loading
In-Reply-To: <20161024100938.GI14477@dell>
References: <20161005155112.13774-1-hdegoede@redhat.com>
 <20161005155112.13774-2-hdegoede@redhat.com>
 <CAGb2v67iQikSHcwS15VmSC6fNMVG9Zya9fz6C6b5+wW43rPZfw@mail.gmail.com>
 <bbd16837-a260-b574-1b1a-1bede038e3de@redhat.com>
 <20161024100938.GI14477@dell>
Message-ID: <20161024101659.GA1440@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > Even though axp20x-i2c seems to be the only "DT only" i2c client,
> > > would it make sense to add DT-based module autoloading to the i2c
> > > core?
> > 
> > If it is not too invasive, then yes that would be a sensible addition IMHO.
> 
> If I understand you correctly, I already have a patch-set on the ML
> that does this.

Incomplete, though. But we will see if Kieran finds time somewhen...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161024/f6b74cf4/attachment.sig>
