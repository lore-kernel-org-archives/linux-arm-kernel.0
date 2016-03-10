From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 10 Mar 2016 13:58:24 +0100
Subject: [PATCH 2/2] isdn: i4l: move active-isdn drivers to staging
In-Reply-To: <56E15211.7080206@linux-pingi.de>
References: <1456945629-1793533-1-git-send-email-arnd@arndb.de>
 <1456945629-1793533-2-git-send-email-arnd@arndb.de>
 <56D7F62E.6050502@linux-pingi.de> <1659125.tHp8H942OG@wuerfel>
 <1457108303.2651.112.camel@tiscali.nl> <56DADA57.9010200@imap.cc>
 <1457340486.2737.19.camel@tiscali.nl> <56E09F4A.8010202@imap.cc>
 <56E15211.7080206@linux-pingi.de>
Message-ID: <1457614704.2478.11.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Karsten,

On do, 2016-03-10 at 11:53 +0100, isdn at linux-pingi.de wrote:
> mISDN with CAPI support works just fine with pppd and pppdcapiplugin
> and the CAPI works for all mISDN HW.

In the mainline tree the mISDN and CAPI stacks are effectively separate.
Do you perhaps refer to a mISDN + Asterisk + chan-capi setup? (That's
the closest to mISDN with CAPI support that I could find. Did I miss
something?)

Thanks,


Paul Bolle
