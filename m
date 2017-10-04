From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Tue, 3 Oct 2017 19:03:29 -0700
Subject: [PATCH 4/7] gpio: brcmstb: correct the configuration of level
 interrupts
In-Reply-To: <20170930034057.15166-5-opendmb@gmail.com>
References: <20170930034057.15166-1-opendmb@gmail.com>
 <20170930034057.15166-5-opendmb@gmail.com>
Message-ID: <CADtm3G6jNNRi6WJMThVCxup81ZDPY5Qk2oUT5PL0z_eiWZ4RUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 8:40 PM, Doug Berger <opendmb@gmail.com> wrote:
> This commit corrects a bug when configuring the GPIO hardware for
> IRQ_TYPE_LEVEL_LOW and IRQ_TYPE_LEVEL_HIGH interrupt types. The
> hardware is now correctly configured to support those types.
>
> Fixes: 19a7b6940b78 ("gpio: brcmstb: Add interrupt and wakeup source support")
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
