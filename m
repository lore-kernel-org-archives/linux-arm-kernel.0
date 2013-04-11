From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 11 Apr 2013 11:07:09 +0200
Subject: [PATCH 11/30] [media] exynos: remove unnecessary header inclusions
In-Reply-To: <20130410211354.397d5689@redhat.com>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-12-git-send-email-arnd@arndb.de>
 <20130410211354.397d5689@redhat.com>
Message-ID: <51667D3D.20103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2013 02:13 AM, Mauro Carvalho Chehab wrote:
> Em Thu, 11 Apr 2013 02:04:53 +0200
> Arnd Bergmann <arnd@arndb.de> escreveu:
> 
>> In multiplatform configurations, we cannot include headers
>> provided by only the exynos platform. Fortunately a number
>> of drivers that include those headers do not actually need
>> them, so we can just remove the inclusions.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Cc: linux-media at vger.kernel.org
>> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> 
> Acked-by: Mauro Carvalho Chehab <mchehab@redhat.com>

This patch is already queued in the media tree for 3.10, and it can
be found in -next now.

Thanks,
Sylwester
