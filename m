From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Fri, 29 Jun 2012 18:42:08 +0530
Subject: [RFC PATCH 3/3] i2c: inititalise the actual transferred to zero
In-Reply-To: <20120629145718.697b6955@endymion.delvare>
References: <1340967927-27354-1-git-send-email-shubhrajyoti@ti.com>
 <1340967927-27354-4-git-send-email-shubhrajyoti@ti.com>
 <20120629144002.3b4a31ee@endymion.delvare>
 <20120629145718.697b6955@endymion.delvare>
Message-ID: <4FEDA9A8.1050504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 June 2012 06:27 PM, Jean Delvare wrote:
> drivers/gpu/drm/nouveau/nouveau_bios.c:3535:3: warning: (near initialization for ?msg[1].actual?) [enabled by default]
>
> This needs to be all fixed (converted to C99-style struct
> initialization) before your patch is considered for inclusion. And
> there may be more that my config did not spot.
Yes,agree.

The idea of this patch was if the idea is agreed upon then.
then fixing all the callers could be worked on.

However do you agree with this approach?
