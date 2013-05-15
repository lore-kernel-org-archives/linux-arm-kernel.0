From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 15 May 2013 09:58:30 +0800
Subject: [PATCH] ASoC: remove saarb and tavorevb3 machine drivers
In-Reply-To: <1368544041.1350.111.camel@x61.thuisdomein>
References: <1368544041.1350.111.camel@x61.thuisdomein>
Message-ID: <CAN1soZyUQRvDWcmefS3SnN=92rOp1LVknHFKzwqO6q88__ULMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 11:07 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> Support for PXA95x was removed in v3.8. This means that the Kconfig
> symbols MACH_SAARB and MACH_TAVOREVB3 are no longer available. This
> leaves the SoC Audio support for Marvell Saarb and Marvell Tavor EVB3
> unbuildable. Remove these drivers too.
>
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
