From: schwab@suse.de (Andreas Schwab)
Date: Wed, 11 Mar 2015 17:09:34 +0100
Subject: [PATCH] arm64: Enable CONFIG_COMPAT also for 64k page size
In-Reply-To: <550062D6.3000101@suse.de> (Alexander Graf's message of "Wed, 11
 Mar 2015 10:44:22 -0500")
References: <1417707993-82290-1-git-send-email-agraf@suse.de>
 <C0CF99B1-8706-4D9B-87E0-13A7C6C619D6@suse.de>
 <mvmegovejx0.fsf@hawking.suse.de> <2583329.jVX0TanYzO@wuerfel>
 <mvma8zjeixd.fsf@hawking.suse.de> <550062D6.3000101@suse.de>
Message-ID: <mvmtwxrcy81.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Graf <agraf@suse.de> writes:

> Andreas, would you like to send this upstream as a proper top-level
> patch or would you prefer if I do a patch set with the 2 patches (enable
> CONFIG_COMPAT on 64k PAGE_SIZE and your patch)?

They only make sense in combination, so go for the patch set.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
