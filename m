From: pbonzini@redhat.com (Paolo Bonzini)
Date: Tue, 03 Jun 2014 11:20:35 +0200
Subject: [RFC PATCH 3/3] PPC, KVM, CMA: use general CMA reserved area
 management framework
In-Reply-To: <xa1ttx82jx1i.fsf@mina86.com>
References: <1401757919-30018-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1401757919-30018-4-git-send-email-iamjoonsoo.kim@lge.com>
 <xa1ttx82jx1i.fsf@mina86.com>
Message-ID: <538D9363.7020203@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 03/06/2014 09:02, Michal Nazarewicz ha scritto:
> On Tue, Jun 03 2014, Joonsoo Kim wrote:
>> Now, we have general CMA reserved area management framework,
>> so use it for future maintainabilty. There is no functional change.
>>
>> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Acked-by: Michal Nazarewicz <mina86@mina86.com>
>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Aneesh, can you test this series?

Paolo
