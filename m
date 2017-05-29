From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 29 May 2017 11:21:07 +0200
Subject: [PATCH v6 4/5] crypto: inside-secure: add SafeXcel EIP197 crypto
 engine driver
In-Reply-To: <CANc+2y46roki41fd_yURACWeXNzjyBEk_kOwiLEr_D=zFyaWuQ@mail.gmail.com>
References: <20170524141035.21031-1-antoine.tenart@free-electrons.com>
 <20170524141035.21031-5-antoine.tenart@free-electrons.com>
 <CANc+2y46roki41fd_yURACWeXNzjyBEk_kOwiLEr_D=zFyaWuQ@mail.gmail.com>
Message-ID: <20170529092107.GA24048@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, May 28, 2017 at 11:09:43AM +0530, PrasannaKumar Muralidharan wrote:
> On 24 May 2017 at 19:40, Antoine Tenart
> <antoine.tenart@free-electrons.com> wrote:
> > Add support for Inside Secure SafeXcel EIP197 cryptographic engine,
> > which can be found on Marvell Armada 7k and 8k boards. This driver
> > currently implements: ecb(aes), cbc(aes), sha1, sha224, sha256 and
> > hmac(sah1) algorithms.
> >
> > Two firmwares are needed for this engine to work. Their are mostly used
> > for more advanced operations than the ones supported (as of now), but we
> > still need them to pass the data to the internal cryptographic engine.
> >
> > Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> 
> As you have got help from other people for testing, wouldn't it be
> nice to add tested-by tag?

Well, they're listed as authors of the driver: not only they helped to
test it but they developed parts of it. The tested-by tag doesn't apply
here.

Thanks,
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170529/38b7902f/attachment.sig>
