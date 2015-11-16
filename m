From: schwab@suse.de (Andreas Schwab)
Date: Mon, 16 Nov 2015 14:34:50 +0100
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <4164423.46Jfedud5Y@wuerfel> (Arnd Bergmann's message of "Mon, 16
 Nov 2015 14:15:58 +0100")
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <5753873.3bKWvUrKmj@wuerfel>
 <alpine.DEB.2.10.1511161230220.25844@digraph.polyomino.org.uk>
 <4164423.46Jfedud5Y@wuerfel>
Message-ID: <mvmziyeukxx.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> ino_t seems to be the only other type in 'struct stat' that depends
> on _FILE_OFFSET_BITS in glibc.

There is also blkcnt_t, and then there is fsblkcnt_t, fsfilcnt_t and
fsword_t in struct statfs.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
