From: rdunlap@infradead.org (Randy Dunlap)
Date: Tue, 31 Dec 2013 10:01:18 -0800
Subject: [ARM] Fix kernel compile error: drivers/crypto/ixp4xx_crypto.c.
In-Reply-To: <20131231134820.GS8064@book.gsilab.sittig.org>
References: <m3d2kduwd7.fsf@t19.piap.pl>
 <20131231134820.GS8064@book.gsilab.sittig.org>
Message-ID: <52C3066E.1070909@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/31/13 05:48, Gerhard Sittig wrote:
> On Tue, Dec 31, 2013 at 11:51 +0100, Krzysztof Ha?asa wrote:
>>
>> drivers/crypto/ixp4xx_crypto.c: In function 'ixp_module_init':
>> drivers/crypto/ixp4xx_crypto.c:1419:2: error: 'dev' undeclared (first use in this function)
>>
>> Now builds. Not tested on real hw.
>>
>> Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>
> 
> I understood that a 'Fixes: <hash> <subject>' line is suggested when
> you can clearly identify what broke what you fix.  Is it 27c1789ca6a6
> "DMA-API: crypto: remove last references to 'static struct device *dev'"?
> Then v3.13-rc1 would have been affected.
 
is 'Fixes: <whatever>' documented somewhere?

thanks,
-- 
~Randy
