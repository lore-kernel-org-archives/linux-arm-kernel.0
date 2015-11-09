From: schwab@suse.de (Andreas Schwab)
Date: Mon, 09 Nov 2015 14:23:59 +0100
Subject: [RFC PATCH v6 00/17] ILP32 for ARM64
In-Reply-To: <20151105221842.GA30634@yury-N73SV> (Yury Norov's message of
 "Fri, 6 Nov 2015 01:18:42 +0300")
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <mvm7flw3cfu.fsf@hawking.suse.de>
 <CA+=Sn1n4-mdTvyiXKpVj9509MrJWGpCeWdGJWcTSU9n2R8PVkg@mail.gmail.com>
 <20151105221842.GA30634@yury-N73SV>
Message-ID: <mvmlha71f2o.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yury Norov <ynorov@caviumnetworks.com> writes:

> This is what I run:
> https://github.com/norov/glibc/tree/thunderx-ilp32-32time_toff_t

That doesn't work for me:

../sysdeps/unix/sysv/linux/generic/sysdep.h:24:22: error: ?__NR_llseek? undeclar
ed (first use in this function)
../sysdeps/unix/sysv/linux/aarch64/sysdep.h:41:32: error: ?__NR_fcntl64? undeclared (first use in this function)

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
