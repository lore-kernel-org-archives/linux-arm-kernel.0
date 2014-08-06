From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 6 Aug 2014 16:34:02 +0200
Subject: CPUIdle Armada 370
In-Reply-To: <1407333701627.99622@vitec.com>
References: <1407333701627.99622@vitec.com>
Message-ID: <20140806143402.GB19574@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 06, 2014 at 02:01:41PM +0000, Nicolas Derouineau wrote:
> Hello,
> I am currently trying to use the CPUIdle driver provided by linux-next (or by the patch here https://github.com/MISL-EBU-System-SW/mainline-public/commits/3.16/cpuidle-v3). 

Hi Nicolas

It is a good idea to CC: Thomas Petazzoni and Gregory Clement. They
wrote this code. I have added them.
 
> Everything runs fine as long as I don't select the CPU driver for
> the ARMADA Family. When I do, at boottime, the program is entering
> the __cpu_suspend save function and then get lost in it and that
> turns into a kernel panic. I have already made a post about this on
> the ARM Community Forum (http://community.arm.com/thread/6326).
> 
> The "faulty" configuration file is attached to this email.
> 
> Any help would be appreciated,
> 
> Regards,
> 
> Nicolas DEROUINEAU
> 


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
