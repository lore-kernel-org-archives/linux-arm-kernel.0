From: schwab@suse.de (Andreas Schwab)
Date: Thu, 17 Dec 2015 15:38:16 +0100
Subject: [PATCH v6 13/20] arm64: ilp32: share aarch32 syscall wrappers to
 ilp32
In-Reply-To: <1450215766-14765-14-git-send-email-ynorov@caviumnetworks.com>
 (Yury Norov's message of "Wed, 16 Dec 2015 00:42:39 +0300")
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-14-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <mvm1tal3ztz.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yury Norov <ynorov@caviumnetworks.com> writes:

> From: Jan Dakinevich <jan.dakinevich@gmail.com>
>
> statfs64, fstat64 and mmap_pgoff has wrappers that needed both by aarch32 and

Typo: s/fstat64/fstatfs64/

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
