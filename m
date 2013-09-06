From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Fri, 06 Sep 2013 20:48:48 +1200
Subject: Query about include/linux/mailbox.h
In-Reply-To: <CABb+yY0FRYgGSmfSXG+vWcsK0aqg_BwULtH7xY6fqFhLF_i5OA@mail.gmail.com>
References: <522177C4.8060205@yahoo.com.au>
 <CABb+yY3wX2=1zh-F81YhhhgM6m+m4+fpVoKDn94m-febAhZGRg@mail.gmail.com>
 <5221D15B.4050507@yahoo.com.au>
 <CABb+yY0FRYgGSmfSXG+vWcsK0aqg_BwULtH7xY6fqFhLF_i5OA@mail.gmail.com>
Message-ID: <522996F0.2040203@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2013 01:39 AM, Jassi Brar wrote:
>> See if I can get my head around that framework and what it does, and try
>> fitting the BCM2835 mailbox into it?
>>
> Yes. If you point me to your mailbox client drivers, I could also give
> it a look to see if we need some changes.

Righty ho. This seems to be a reasonable attempt.

https://github.com/rickytarr/linux/tree/subsys-mailbox
https://github.com/rickytarr/linux/commit/e0c25371581d125e3f6a46f452ce3e95f1d267ee

It compiles cleanly and boots.  Start with bcm2835_defconfig, and then 
enable Device Drivers -> Mailbox Hardware Support -> BCM 2835 Mailbox. I 
think it validates that BCM2835 mailbox support can fit into your 
generic device.

But that's as far as I know.  I'm offering this as an early look only 
(comments and defects welcome). I've got to build something that uses it 
next.  For all I know it might cause the Raspberry Pi to explode and 
vaporise any desk it is sitting on.

Out of interest, do you have a roadmap for moving this into the kernel 
mainline?

Cheers,
Craig.
