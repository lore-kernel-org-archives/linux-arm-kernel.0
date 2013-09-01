From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Sun, 01 Sep 2013 20:53:32 +1200
Subject: Query about include/linux/mailbox.h
In-Reply-To: <CABb+yY0FRYgGSmfSXG+vWcsK0aqg_BwULtH7xY6fqFhLF_i5OA@mail.gmail.com>
References: <522177C4.8060205@yahoo.com.au>
 <CABb+yY3wX2=1zh-F81YhhhgM6m+m4+fpVoKDn94m-febAhZGRg@mail.gmail.com>
 <5221D15B.4050507@yahoo.com.au>
 <CABb+yY0FRYgGSmfSXG+vWcsK0aqg_BwULtH7xY6fqFhLF_i5OA@mail.gmail.com>
Message-ID: <5223008C.1070402@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2013 01:39 AM, Jassi Brar wrote:
> Yes. If you point me to your mailbox client drivers, I could also give
> it a look to see if we need some changes.

This should be a reasonably concise view of things.

https://github.com/rickytarr/linux/commit/a9b131c63c73c450a567eb5fa527e8919e71bfd8

There is no header for the BCM2835 mailbox.  At the point I started to 
add one, I learnt more about the multi-architecture approach to SoC 
code, and realised I'm going to have to rethink what I'm doing.

I don't think your code will need to change much, if at all.  I'll try 
applying your patches and see what happens.

Cheers,
Craig.
