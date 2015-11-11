From: schwab@suse.de (Andreas Schwab)
Date: Wed, 11 Nov 2015 18:54:00 +0100
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <1446507046-24604-14-git-send-email-ynorov@caviumnetworks.com>
 (Yury Norov's message of "Tue, 3 Nov 2015 02:30:42 +0300")
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <1446507046-24604-14-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <mvmsi4cxw07.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yury Norov <ynorov@caviumnetworks.com> writes:

> +#define sys_clock_gettime       compat_sys_clock_gettime
> +#define sys_clock_settime       compat_sys_clock_settime

You also need to redirect sys_clock_nanosleep.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
