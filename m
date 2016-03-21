From: schwab@suse.de (Andreas Schwab)
Date: Mon, 21 Mar 2016 11:52:54 +0100
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <6653982.FK62mVSCZO@wuerfel> (Arnd Bergmann's message of "Mon, 21
 Mar 2016 10:43:48 +0100")
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <20160318154918.GA1595@yury-N73SV> <mvmoaa8dwre.fsf@hawking.suse.de>
 <6653982.FK62mVSCZO@wuerfel>
Message-ID: <mvmbn68drw9.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> What exactly do you need to define F_GETLK64 for on LP64?

To override the generic definitions.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
