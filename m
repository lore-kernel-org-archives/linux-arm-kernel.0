From: tilman@imap.cc (Tilman Schmidt)
Date: Wed, 9 Mar 2016 23:10:18 +0100
Subject: [PATCH 2/2] isdn: i4l: move active-isdn drivers to staging
In-Reply-To: <1457340486.2737.19.camel@tiscali.nl>
References: <1456945629-1793533-1-git-send-email-arnd@arndb.de>
 <1456945629-1793533-2-git-send-email-arnd@arndb.de>
 <56D7F62E.6050502@linux-pingi.de> <1659125.tHp8H942OG@wuerfel>
 <1457108303.2651.112.camel@tiscali.nl> <56DADA57.9010200@imap.cc>
 <1457340486.2737.19.camel@tiscali.nl>
Message-ID: <56E09F4A.8010202@imap.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 07.03.2016 um 09:48 schrieb Paul Bolle:
> On za, 2016-03-05 at 14:08 +0100, Tilman Schmidt wrote:
>> As a consequence, owners of HiSAX type adapters are in fact stuck with
>> the old hisax driver if they want to continue using i4l userspace
>> tools.
> 
> Do you know whether or not mISDN tools offer functionality comparable to
> i4l tools?

AFAICS they don't. mISDN seems very much geared towards voice use, for
example with Asterisk. The entire topic of ISDN data connections appears
to be missing. I don't see how someone currently using i4l for Internet
dial-in (either client or server side) could migrate to mISDN.

-- 
Tilman Schmidt                              E-Mail: tilman at imap.cc
Bonn, Germany
Nous, on a des fleurs et des bougies pour nous prot?ger.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160309/cb4342b1/attachment.sig>
