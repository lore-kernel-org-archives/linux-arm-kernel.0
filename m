From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 7 Oct 2014 09:31:31 -0700
Subject: [PATCH 05/44] mfd: as3722: Drop reference to pm_power_off from
 devicetree bindings
In-Reply-To: <543412F7.8040909@landley.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-6-git-send-email-linux@roeck-us.net>
 <543412F7.8040909@landley.net>
Message-ID: <20141007163131.GE28835@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 11:21:11AM -0500, Rob Landley wrote:
> On 10/07/14 00:28, Guenter Roeck wrote:
> > Devicetree bindings are supposed to be operating system independent
> > and should thus not describe how a specific functionality is implemented
> > in Linux.
> 
> So your argument is that linux/Documentation/devicetree/bindings should
> not be specific to Linux. Merely hosted in the Linux kernel source
> repository.
> 
> Well that's certainly a point of view.
> 
Not specifically my argument, really, and nothing new either. But, yes, I do
think that devicetree bindings descriptions should not include implementation
details, especially since those may change over time (as is the case here).

Thanks,
Guenter
