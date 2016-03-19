From: tilman@imap.cc (Tilman Schmidt)
Date: Sat, 19 Mar 2016 11:27:25 +0100
Subject: [PATCH 2/2] isdn: i4l: move active-isdn drivers to staging
In-Reply-To: <87lh5udbcv.fsf@gmail.com>
References: <1456945629-1793533-1-git-send-email-arnd@arndb.de>
 <1456945629-1793533-2-git-send-email-arnd@arndb.de>
 <56D7F62E.6050502@linux-pingi.de> <1659125.tHp8H942OG@wuerfel>
 <87lh5udbcv.fsf@gmail.com>
Message-ID: <56ED298D.4020100@imap.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 07.03.2016 um 07:57 schrieb Holger Schurig:
> I know that in Germany a good amount of land-line telephone line are
> still using ISDN. [...]
> Especially company line are using ISDN still, and there are some Linux
> programs that act on then, e.g. Asterisk and derived PBX software has
> ISDN support which is actively used.

AFAIK none of these uses I4L anymore. Asterisk dropped I4L support with
version 2 if my memory is correct and nowadays uses CAPI, mISDN or its
own DAHDI interface.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160319/57f56281/attachment-0001.sig>
