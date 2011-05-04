From: will.deacon@arm.com (Will Deacon)
Date: Wed, 04 May 2011 18:27:36 +0100
Subject: [PATCH] atomic: add *_dec_not_zero
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
Message-ID: <1304530056.2296.1.camel@craptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-05-03 at 22:30 +0100, Sven Eckelmann wrote:
> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.
> 
For the ARM changes:

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
