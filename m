From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 17 Jan 2018 13:23:33 +0900
Subject: [PATCH v2 02/13] iommu/rockchip: Suppress unbinding
In-Reply-To: <20180116132540.18939-3-jeffy.chen@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
 <20180116132540.18939-3-jeffy.chen@rock-chips.com>
Message-ID: <CAAFQd5C_d2JW6kPQOMQ=mB6kHMdNZQGFvamjaDhexoPD_4W7+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 10:25 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> It's not safe to unbind rockchip IOMMU driver.

Might be good to explain why it is not safe and actually add that it
does not make any sense for such low level devices.

Best regards,
Tomasz
