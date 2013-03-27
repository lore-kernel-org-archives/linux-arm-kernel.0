From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Tue, 26 Mar 2013 23:39:16 -0300
Subject: [PATCH 0/2] rename sunxi clock compatible strings
Message-ID: <1364351958-14503-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As discussed with Maxime, we decided to rename the compatible strings
to sun4i, to keep it coherent when support for sun6i and newer is 
introduced. See "ARM: sunxi: Architecture cleanups and rework" and these 
patch messages for the full rationale.

I will be sending a v2 of "clk: sunxi: gates support" soon, using 
sun4i compatible strings, based on these two patches.

Thanks,

Emilio

Emilio L?pez (2):
  clk: sunxi: rename compatible strings
  arm: sunxi: rename clock compatible strings
