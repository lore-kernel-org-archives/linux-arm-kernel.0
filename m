From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Fri, 07 Sep 2012 15:13:31 +0200
Subject: [PATCH] ARM: ixp4xx: move fixed mapping of internal devices into
 vmalloc region
In-Reply-To: <201209071223.30275.arnd@arndb.de> (Arnd Bergmann's message of
 "Fri, 7 Sep 2012 12:23:29 +0000")
References: <1346996400-5824-1-git-send-email-gerg@snapgear.com>
 <201209071223.30275.arnd@arndb.de>
Message-ID: <m3oblic6x0.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

>>   BUG: mapping for 0xc8000000 at 0xffbeb000 out of vmalloc space
>>   BUG: mapping for 0xc4000000 at 0xffbfe000 out of vmalloc space
>>   BUG: mapping for 0xc0000000 at 0xffbff000 out of vmalloc space

> Imre, Krzysztof: do you prefer to take this patch into a branch of yours
> and send a pull request, or should we just apply it directly into arm-soc.
> In the former case, can you provide an Ack?

My intention is to push the following instead:

http://git.kernel.org/?p=linux/kernel/git/chris/linux.git;a=commitdiff;h=f62736b567ff532fb772afea76fccdbcd92ab473;hp=23e3b6cf1c37ef0615d90681d3705a8821305b5f
-- 
Krzysztof Halasa
