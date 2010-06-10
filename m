From: milinevskyy@gmail.com (Dmytro Milinevskyy)
Date: Thu, 10 Jun 2010 04:56:27 +0300
Subject: [PATCH] Marvell OpenRD-Ultimate machine support
In-Reply-To: <20100609204257.GJ1743@mail.wantstofly.org>
References: <4c0ff6b2.0c3ddf0a.2185.2e09@mx.google.com>
	<20100609203720.GK7660@chipmunk> <20100609203929.GL7660@chipmunk>
	<20100609204257.GJ1743@mail.wantstofly.org>
Message-ID: <AANLkTimYjHs29xfc7WpwJROXM4maAlquJb-7REo1GmFy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

>>
>> Better still, just make this 'if(!machine_is_openrd_base())'.
>
> That form is more error prone when someone adds the OpenRD-SuperDuper,
> though.
>

I agree, and the similar could be done in pcie initialization.

-- Dima
