From: cphealy@gmail.com (Chris Healy)
Date: Wed, 19 Sep 2018 07:45:28 -0700
Subject: [PATCH 2/2] ARM: dts: imx6qdl-zii-rdu2: Disable the internal RTC
In-Reply-To: <1537271012-5159-2-git-send-email-festevam@gmail.com>
References: <1537271012-5159-1-git-send-email-festevam@gmail.com>
 <1537271012-5159-2-git-send-email-festevam@gmail.com>
Message-ID: <CAFXsbZr29Kj97s226iUyC9TM5YAGx4svpL3h6ipcSKD0TTyPgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On the imx6qdl-zii-rdu2 board the RTC functionality is provided via
> a DS1341 RTC connected via I2C bus, so we can safely disable the internal
> one.

Tested-by: Chris Healy <cphealy@gmail.com>
