From: henrik@henriknordstrom.net (Henrik =?ISO-8859-1?Q?Nordstr=F6m?=)
Date: Wed, 27 Aug 2014 12:26:11 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140827085538.GS15297@lukather>
References: <20140825150705.GB15297@lukather> <20140826082626.GE17263@ulmo>
 <20140826090035.GB17528@sirena.org.uk> <20140826091853.GI17263@ulmo>
 <20140826100612.GH17528@sirena.org.uk> <20140826105451.GD31124@ulmo>
 <1409078409.2701.17.camel@localhost> <20140827074057.GS17528@sirena.org.uk>
 <20140827082208.GQ15297@lukather>
 <CAMuHMdVkEPBtVT0dcDqQOQ_J0p+zYJwaUW8LqQX0Z+h6CHihRg@mail.gmail.com>
 <20140827085538.GS15297@lukather>
Message-ID: <1409135171.9896.3.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ons 2014-08-27 klockan 10:55 +0200 skrev Maxime Ripard:

> If we just rely on a simplefb node, when reviewing and integrating the
> "new" bindings to describe accureately the various IPs involved in the
> display path, we would obviously create new compatibles for
> them. Since it's new compatibles, we can come up with any binding we'd
> like, without have to consider the backward compatibility, since it's
> a new binding.

My gut feeling is that the attributes needed by simplefb belong in the
actual hardware node somehow, with a standard layout so it can be
applied on all compatible video devices.

The complication is that these attributes is volatile and not really
set/defined by hardware. Similar to UART baud rate (and kernel command
line if you like).

Regards
Henrik
 
