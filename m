From: romain.perier@free-electrons.com (Romain Perier)
Date: Thu, 16 Jun 2016 15:41:54 +0200
Subject: [PATCH 5/7] crypto: marvell: Adding a complete operation for
 async requests
In-Reply-To: <20160615225531.4e060f11@bbrezillon>
References: <1466018134-10779-1-git-send-email-romain.perier@free-electrons.com>
 <1466018134-10779-6-git-send-email-romain.perier@free-electrons.com>
 <20160615225531.4e060f11@bbrezillon>
Message-ID: <5762ACA2.3050703@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le 15/06/2016 22:55, Boris Brezillon a ?crit :
>> +
>
> Nit: not sure you should mix this cosmetic change with the other
> changes.

Ok


> You already have ivsize initialized.
>
>> +		memcpy_fromio(ablkreq->info, basereq->chain.last->data, ivsize);
>
> Use memcpy() here.

good catch, for both.

Thanks,
Romain
-- 
Romain Perier, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
