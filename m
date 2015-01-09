From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 9 Jan 2015 07:25:02 -0800
Subject: [PATCH v3 0/7] Pinctrl support for Zynq
In-Reply-To: <CACRpkdaKH21qz_RAcDtw6ycsw+5FD0RXQQs91_tZV53EuKVusQ@mail.gmail.com>
References: <1d59c0972da04ec89dec6c09724986a1@BY2FFO11FD010.protection.gbl>
 <4d544fe425694a4e8043ddbf604db062@BN1AFFO11FD033.protection.gbl>
 <CACRpkdaKH21qz_RAcDtw6ycsw+5FD0RXQQs91_tZV53EuKVusQ@mail.gmail.com>
Message-ID: <ba4ac5f77c7549f2a264a5a5b1318dc8@BN1BFFO11FD009.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-01-09 at 09:45AM +0100, Linus Walleij wrote:
> On Fri, Dec 12, 2014 at 5:37 PM, S?ren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> 
> > Argh, this went through the wrong SMTP. I suspect threading is broken
> > due to that. Let me know if you want me to resend this with intact
> > threading.
> 
> I don't care much about the threading, but all messages are quoted-printable
> which doesn't apply :(
> 
> i.e.:
> 
> Content-Transfer-Encoding: quoted-printable
> (...)
> 
> + const char *subnode_target_type =3D "pins";
> =20
> (...)
> 
> Can you resent with more sane encoding? I don't know where this
> comes from but suspect the Microsoft Exchange SMTP server
> does this when you use diacritics and german letters...

Okay, I'll rebase to the latest pinctrl/devel branch (if needed) and
send an updated version bypassing exchange. I hope that works then.

	Thanks,
	S?ren
