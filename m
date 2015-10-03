From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Sat, 03 Oct 2015 15:04:49 +0200
Subject: [PATCH v4 26/26] ARM: pxa: magician: Move
 platform_add_devices() to the end of magician_init()
In-Reply-To: <5609B43F.4070200@tul.cz>
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609B43F.4070200@tul.cz>
Message-ID: <1443877489.4186.44.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 28.09.2015, 23:42 +0200 schrieb Petr Cvek:
> This patch moves platform_add_devices() (standard declaration of
> devices)
> outside of the platform specific device declarations. Moving to the
> end
> of the magician_init() clarifies the source code (standard and
> specific
> declaration are not mixed).
> 
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>

Acked-by: Philipp Zabel <philipp.zabel@gmail.com>
