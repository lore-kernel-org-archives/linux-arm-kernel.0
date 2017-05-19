From: romain.perier@collabora.com (Romain Perier)
Date: Fri, 19 May 2017 08:56:53 +0200
Subject: [PATCH v3 1/3] SoC: es8328-i2c: Add compatible for ES8323
In-Reply-To: <20170516111837.3uf5f5jbdkrnjudi@sirena.org.uk>
References: <20170512132227.24916-1-romain.perier@collabora.com>
 <20170512132227.24916-10-romain.perier@collabora.com>
 <20170515214138.u63u7j53jogk3prm@rob-hp-laptop>
 <20170516111837.3uf5f5jbdkrnjudi@sirena.org.uk>
Message-ID: <a052da20-d9c7-69f5-21d9-9111d45702e6@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,


Le 16/05/2017 ? 13:18, Mark Brown a ?crit :
> On Mon, May 15, 2017 at 04:41:38PM -0500, Rob Herring wrote:
>> On Fri, May 12, 2017 at 03:22:25PM +0200, Romain Perier wrote:
>>> This commit adds a compatible string for everest,es8323. This is an
>>> audio codec that is compatible with es8328 and can be found for example
>>> on the Firefly-RK3288 board.
>> If it is compatible with the es8328, then that should be a fallback and 
>> you don't need the driver change.
> While people don't strictly need the driver change it doesn't do any
> harm either and encourages people to get the information into the DT
> that it's a different chip.  Thinking about it it might be good to have
> a way for something to validate if fallback compatibles are being listed
> when they should - the drivers could provide the information fairly
> easily I guess, or it could go into the binding docs once we have a
> schema format.
>
> Even if it doesn't currently make a difference to software I'd rather
> get the information in there for mixed signal devices like audio CODECs
> - it's not that unknown to find later that supposedly register identical
> chips have some differences in the analog which we want to care about.
So, what should I do for this patch, finally ? fallback or driver change ?

Thanks,
Romain
