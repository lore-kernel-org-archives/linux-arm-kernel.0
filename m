From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 16:59:08 +0200
Subject: [PATCH v3 2/3] hwmon: xgene: Add hwmon driver
In-Reply-To: <6c6118cf-f9cf-d5f2-dde0-afea0143687c@roeck-us.net>
References: <1469134557-26869-1-git-send-email-hotran@apm.com>
 <8664936.LICyesLN7G@wuerfel>
 <6c6118cf-f9cf-d5f2-dde0-afea0143687c@roeck-us.net>
Message-ID: <2240578.V3yYtMQl2O@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 7:55:44 AM CEST Guenter Roeck wrote:
> Maybe, but now I get
> 
> Building arm:allmodconfig ... failed
> --------------
> Error log:
> crypto/crypto_engine.c: In function 'crypto_transfer_hash_request':
> crypto/crypto_engine.c:234:3: error: implicit declaration of function 'queue_kthread_work'
> 
> Building arm64:allmodconfig ... failed
> --------------
> Error log:
> arch/arm64/kvm/../../../virt/kvm/arm/arch_timer.c: In function ?kvm_timer_hyp_init?:
> arch/arm64/kvm/../../../virt/kvm/arm/arch_timer.c:457:1: warning: label ?out_free? defined but not used

Right, I sent fixes for both. I think we had a clean build yesterday,
probably tomorrow those will both be fixed.

The time between -rc5 and -rc7 seems to be the worst for build testing ;-)

	Arnd
