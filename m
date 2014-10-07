From: rob@landley.net (Rob Landley)
Date: Tue, 07 Oct 2014 11:21:11 -0500
Subject: [PATCH 05/44] mfd: as3722: Drop reference to pm_power_off from
 devicetree bindings
In-Reply-To: <1412659726-29957-6-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-6-git-send-email-linux@roeck-us.net>
Message-ID: <543412F7.8040909@landley.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/14 00:28, Guenter Roeck wrote:
> Devicetree bindings are supposed to be operating system independent
> and should thus not describe how a specific functionality is implemented
> in Linux.

So your argument is that linux/Documentation/devicetree/bindings should
not be specific to Linux. Merely hosted in the Linux kernel source
repository.

Well that's certainly a point of view.

Rob
