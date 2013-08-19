From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 19 Aug 2013 23:45:31 +0200
Subject: [PATCH v4 3/3] ARM: bcm281xx: Device Tree bindings for GPIO driver
In-Reply-To: <1376938761-13657-4-git-send-email-markus.mayer@linaro.org>
References: <1376938761-13657-1-git-send-email-markus.mayer@linaro.org>
 <1376938761-13657-4-git-send-email-markus.mayer@linaro.org>
Message-ID: <7172097.b0dioE2CoB@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

The patch looks good overall, just a little nitpick about the commit 
message.

On Monday 19 of August 2013 11:59:21 Markus Mayer wrote:
> GPIO device tree bindings for the Broadcom bcm281xx family of chips

Device tree bindings are sets of properties and subnodes defined for 
device nodes used to describe those devices. In other words, bindings are 
what you have described in numerous files 
Documentation/devicetree/bindings.

What this patch is adding is a device node for the GPIO controller of 
bcm11351.

Other than that:

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
