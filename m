From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 26 Mar 2014 11:57:03 -0300
Subject: [PATCH 1/2] ARM: dts: imx51-babbage: Add USB Host1 support
In-Reply-To: <26dd7d7d9b5f481588848b0fdd65fbbb@BL2PR03MB226.namprd03.prod.outlook.com>
References: <1395750922-3244-1-git-send-email-festevam@gmail.com>
 <07405bf6fc4841d5b0d22c07c582acb9@BL2PR03MB226.namprd03.prod.outlook.com>
 <CAOMZO5Da9poOv8KqCsSxnjs4eZkVbRPCmnJCj-OX3ps8=+y+Ww@mail.gmail.com>
 <26dd7d7d9b5f481588848b0fdd65fbbb@BL2PR03MB226.namprd03.prod.outlook.com>
Message-ID: <CAOMZO5AriA91au6heDFTJAdL5j020=MYb39YhEQ6APYH2MnT5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 2:36 AM, Peter Chen <Peter.Chen@freescale.com> wrote:

> For imx53, it can work since both usbotg and host 1 use utmi internal phy.
> But for SoCs before than imx53 (including imx51), the host1 uses external
> phy. At non-dt version, they should use ulpi phy driver.

Ok, got it. Please check v2.

Regards,

Fabio Estevam
