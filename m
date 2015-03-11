From: agraf@suse.de (Alexander Graf)
Date: Wed, 11 Mar 2015 13:11:35 -0500
Subject: [PATCH] arm64: Enable CONFIG_COMPAT also for 64k page size
In-Reply-To: <mvmtwxrcy81.fsf@hawking.suse.de>
References: <1417707993-82290-1-git-send-email-agraf@suse.de>	<C0CF99B1-8706-4D9B-87E0-13A7C6C619D6@suse.de>	<mvmegovejx0.fsf@hawking.suse.de>
 <2583329.jVX0TanYzO@wuerfel>	<mvma8zjeixd.fsf@hawking.suse.de>
 <550062D6.3000101@suse.de> <mvmtwxrcy81.fsf@hawking.suse.de>
Message-ID: <55008557.3000200@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11.03.15 11:09, Andreas Schwab wrote:
> Alexander Graf <agraf@suse.de> writes:
> 
>> Andreas, would you like to send this upstream as a proper top-level
>> patch or would you prefer if I do a patch set with the 2 patches (enable
>> CONFIG_COMPAT on 64k PAGE_SIZE and your patch)?
> 
> They only make sense in combination, so go for the patch set.

Ok, can you please give me a signed-off-by line for your patch then? :)


Alex
