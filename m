From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 6 Jun 2016 13:44:29 -0400 (EDT)
Subject: [PATCH 9/10] usb: host: ehci-st: Inform the reset framework that
 our reset line may be shared
In-Reply-To: <20160606170854.12407-2-lee.jones@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1606061344011.2049-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Jun 2016, Lee Jones wrote:

> On the STiH410 B2120 development board the ST EHCI IP shares its reset
> line with the OHCI IP.  New functionality in the reset subsystems forces
> consumers to be explicit when requesting shared/exclusive reset lines.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

For this andd the 10/10 patch:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
