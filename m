From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 12 Oct 2014 19:01:39 +0200
Subject: [RFC] drop owner assignment from platform_drivers
In-Reply-To: <20141012142455.GC21479@kroah.com>
References: <20141010072439.GA1741@katana>
 <20141010083627.GL5182@n2100.arm.linux.org.uk>
 <20141010182604.GC6075@katana> <2769473.KEN6DZKnT7@wuerfel>
 <20141011165650.GA1263@katana> <20141011205527.GA30877@kroah.com>
 <20141012055146.GA1310@katana> <20141012142455.GC21479@kroah.com>
Message-ID: <20141012170139.GA1389@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > So, what is your opinion on the original cleanup series removing
> > unnecessary '.owner = THIS_MODULE' lines in drivers? Helpful? Noise?
> 
> Helpful, please do it.  I can take it all through my driver-core tree if
> you want, that might make things easier for others.

Thanks, that might make sense this time.

So, I'll prepare the bugfixes, add the semantic patch, add this all to
my series and respin. It might take a few days because of ELCE in
D?sseldorf, but I'll certainly do it.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141012/42fdefca/attachment-0001.sig>
