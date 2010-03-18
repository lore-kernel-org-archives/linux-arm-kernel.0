From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Mar 2010 11:53:33 +0000
Subject: [PATCH 1/2] AT91: taskit PortuxG20 and Stamp9G20 board support
In-Reply-To: <1268912416-4886-2-git-send-email-christian.glindkamp@taskit.de>
References: <1268912416-4886-1-git-send-email-christian.glindkamp@taskit.de>
	<1268912416-4886-2-git-send-email-christian.glindkamp@taskit.de>
Message-ID: <20100318115333.GD19544@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 18, 2010 at 12:40:15PM +0100, Christian Glindkamp wrote:
> +#include <mach/board.h>
> +#include <mach/gpio.h>

linux/gpio.h please.
