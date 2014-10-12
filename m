From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 12 Oct 2014 07:51:46 +0200
Subject: [RFC] drop owner assignment from platform_drivers
In-Reply-To: <20141011205527.GA30877@kroah.com>
References: <20141010072439.GA1741@katana>
 <20141010083627.GL5182@n2100.arm.linux.org.uk>
 <20141010182604.GC6075@katana> <2769473.KEN6DZKnT7@wuerfel>
 <20141011165650.GA1263@katana> <20141011205527.GA30877@kroah.com>
Message-ID: <20141012055146.GA1310@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I missed the one code path you pointed out, and that should be fixed,
> but that doesn't mean that the original patch should be reverted, as it
> is the way we want things to be, let's just fix up the bug and move on.

OK, that is a clear statement.

So, what is your opinion on the original cleanup series removing
unnecessary '.owner = THIS_MODULE' lines in drivers? Helpful? Noise?

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141012/e36936a0/attachment-0001.sig>
