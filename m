From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 30 Nov 2014 11:07:18 +0100
Subject: [PATCH] kvm: arm: vgic: Let one looping code instead of two
 looping code
In-Reply-To: <547A9A7C.1080508@gmail.com>
References: <547A9A7C.1080508@gmail.com>
Message-ID: <20141130100718.GA484@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 30, 2014 at 12:18:04PM +0800, Chen Gang wrote:
> Use one looping instead of two, so can let code more simpler and get a
> little better performance.
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>

Performance?  Please, this is vgic_create....

This does nothing else than introduce churn.

-Christoffer
