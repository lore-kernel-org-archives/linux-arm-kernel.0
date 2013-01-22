From: kishon@ti.com (kishon)
Date: Tue, 22 Jan 2013 21:10:57 +0530
Subject: [PATCH v1 6/6] USB: MUSB: OMAP: get PHY by phandle for dt boot
In-Reply-To: <50FEB275.80504@ti.com>
References: <1358848694-20145-1-git-send-email-kishon@ti.com>
 <1358848694-20145-7-git-send-email-kishon@ti.com> <50FE9F5C.2010501@ti.com>
 <50FEA447.1090701@ti.com> <50FEA696.8000506@ti.com> <50FEAE96.30706@ti.com>
 <50FEB275.80504@ti.com>
Message-ID: <50FEB309.9040709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 22 January 2013 09:08 PM, Peter Ujfalusi wrote:
> On 01/22/2013 04:21 PM, kishon wrote:
>> But it's better to check if deferred probing
>> takes place whenever a new driver is bound to a device as you just mentioned.
>
> Whenever you load (might be also when you unload) a driver the deferred
> modules will try to probe again. This is to check back if the dependency of
> the deferred modules has been fulfilled by the new driver or not.

Thanks Peter.

-Kishon
