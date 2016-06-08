From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 8 Jun 2016 10:17:48 -0700
Subject: [PATCH] ARM: bcm: fix missing include of kona_l2_cache.h
In-Reply-To: <03175266-48af-fe2c-6e36-cf977c658596@broadcom.com>
References: <1465403758-2173-1-git-send-email-ben.dooks@codethink.co.uk>
 <03175266-48af-fe2c-6e36-cf977c658596@broadcom.com>
Message-ID: <5758533C.8050103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2016 09:40 AM, Ray Jui wrote:
> Hi Ben,
> 
> On 6/8/2016 9:35 AM, Ben Dooks wrote:
>> Fix a warning of kona_l2_cache_init() not being declared by
>> including the header file kona_l2_cache.h which defines it
>> thus fixing:
>>
>> arch/arm/mach-bcm/kona_l2_cache.c:21:13: warning: symbol
>> 'kona_l2_cache_init' was not declared. Should it be static?
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Acked-by: Ray Jui <ray.jui@broadcom.com>

Applied, thanks!
-- 
Florian
