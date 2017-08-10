From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Aug 2017 09:38:17 -0700
Subject: [PATCH v2] arm: dts: omap3: Remove needless interrupt-parent
 property
In-Reply-To: <1498546060-5742-1-git-send-email-karthik@techveda.org>
References: <41ab5d17-620e-34b6-bd1c-33ae7bb3234c@techveda.org>
 <1498546060-5742-1-git-send-email-karthik@techveda.org>
Message-ID: <20170810163816.GH8569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* karthik at techveda.org <karthik@techveda.org> [170626 23:48]:
> From: Karthik Tummala <karthik@techveda.org>
> 
> All nodes inhert "interrupt-parent" property from root
> node. Removed the aforementioned property from usbhsohci,
> usbhsehci, ssi_port1, ssi_port2 nodes to avoid duplication.
> 
> Signed-off-by: Karthik Tummala <karthik@techveda.org>
> ---
> Changes for v2:
> - Made changes to subject & description as suggested by
>   Suniel Mahesh.

Applying into omap-for-v4.14/dt thanks.

Tony
