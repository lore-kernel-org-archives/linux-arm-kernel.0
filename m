From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 05 Aug 2010 16:25:25 +0900
Subject: [PATCH 0/5] ARM: S5PC110: GPIO feature update
Message-ID: <20100805072525.GA22257@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The main feature is that introduce the group field for easy calculation
 of register offset and interrupt number.

Also fix the correct meanings of GPIOs and support the gpio_to_irq for external interrupt.
