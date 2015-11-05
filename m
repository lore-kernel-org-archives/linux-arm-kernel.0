From: schwab@suse.de (Andreas Schwab)
Date: Thu, 05 Nov 2015 12:36:37 +0100
Subject: [RFC PATCH v6 00/17] ILP32 for ARM64
In-Reply-To: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 (Yury Norov's message of "Tue, 3 Nov 2015 02:30:29 +0300")
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <mvm7flw3cfu.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yury Norov <ynorov@caviumnetworks.com> writes:

> v6:
>  - time_t, __kenel_off_t and other types turned to be 32-bit
>    for compatibility reasons (after v5 discussion);

Are the updated glibc patches available somewhere?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
