From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Tue, 3 Oct 2017 18:40:27 -0700
Subject: [PATCH 1/7] gpio: brcmstb: allow all instances to be wakeup
 sources
In-Reply-To: <20170930034057.15166-2-opendmb@gmail.com>
References: <20170930034057.15166-1-opendmb@gmail.com>
 <20170930034057.15166-2-opendmb@gmail.com>
Message-ID: <CADtm3G4ADyD-nGpFZ2OD2fH6PMpEipykJuuLxz+S8mvXUV6VPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 8:40 PM, Doug Berger <opendmb@gmail.com> wrote:
> This commit allows a wakeup parent interrupt to be shared between
> instances.
>
> It also removes the redundant can_wake member of the private data
> structure by using whether the parent_wake_irq has been defined to
> indicate that the GPIO device can wake.
>
> Fixes: 19a7b6940b78 ("gpio: brcmstb: Add interrupt and wakeup source support")
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
