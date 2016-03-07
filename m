From: holgerschurig@gmail.com (Holger Schurig)
Date: Mon, 07 Mar 2016 07:57:04 +0100
Subject: [PATCH 2/2] isdn: i4l: move active-isdn drivers to staging
In-Reply-To: <1659125.tHp8H942OG@wuerfel> (Arnd Bergmann's message of "Fri, 04
 Mar 2016 16:24:19 +0100")
References: <1456945629-1793533-1-git-send-email-arnd@arndb.de>
 <1456945629-1793533-2-git-send-email-arnd@arndb.de>
 <56D7F62E.6050502@linux-pingi.de> <1659125.tHp8H942OG@wuerfel>
Message-ID: <87lh5udbcv.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I know that in Germany a good amount of land-line telephone line are
still using ISDN. Some telco company try to move people to IP only, but
this is currently still a process.

Especially company line are using ISDN still, and there are some Linux
programs that act on then, e.g. Asterisk and derived PBX software has
ISDN support which is actively used.
