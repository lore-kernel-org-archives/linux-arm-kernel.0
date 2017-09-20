From: ydroneaud@opteya.com (Yann Droneaud)
Date: Wed, 20 Sep 2017 13:18:04 +0200
Subject: [kernel-hardening] [PATCH v2 0/5] stackprotector: ascii armor
 the stack canary
In-Reply-To: <20170919171600.GA31441@openwall.com>
References: <20170524155751.424-1-riel@redhat.com>
 <20170919171600.GA31441@openwall.com>
Message-ID: <1505906284.3490.5.camel@opteya.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le mardi 19 septembre 2017 ? 19:16 +0200, Solar Designer a ?crit :
>
> We could put/require a NUL in the middle of the canary,
> but with the full canary being only 64-bit at most that would also
> make some attacks easier.
> 

Are you suggesting to randomly select which byte to set to 0 in each
canary ?

Regards.

-- 
Yann Droneaud
OPTEYA
