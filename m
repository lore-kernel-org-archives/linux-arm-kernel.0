From: robherring2@gmail.com (Rob Herring)
Date: Thu, 30 Aug 2012 22:00:28 -0500
Subject: [PATCH 03/10] serial: atmel: add explict mach/gpio.h include
In-Reply-To: <20120829233705.GT18957@n2100.arm.linux.org.uk>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
 <1346279496-26286-4-git-send-email-robherring2@gmail.com>
 <20120829233705.GT18957@n2100.arm.linux.org.uk>
Message-ID: <504028CC.9020202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/2012 06:37 PM, Russell King - ARM Linux wrote:
> On Wed, Aug 29, 2012 at 05:31:29PM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> In preparation to remove implicit inclusion of mach/gpio.h, add explicit
>> include of mach/gpio.h.
> 
> Definitely NAK.
> 
> What is in the Atmel mach/gpio.h has hardly anything to do with the
> gpio subsystem (it's more a private gpio implementation).  It should
> be renamed as such to make it clear (and so it doesn't trigger my
> sanity filtering.)

Jean-Christophe, Does your gpio clean-up address this?

Rob
