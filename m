From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Nov 2012 23:08:36 +0000
Subject: [RFC 3/3] ARM/AVR32: get rid of serial_at91.h
In-Reply-To: <CAGhQ9VzYc8qqvZxU=AB+NHa4nGKJFxPYR7grc8Ssn-kP1bfq3w@mail.gmail.com>
References: <20120921093530.GB31374@n2100.arm.linux.org.uk>
 <E1TEzfE-000780-1t@rmk-PC.arm.linux.org.uk>
 <CAGhQ9VzYc8qqvZxU=AB+NHa4nGKJFxPYR7grc8Ssn-kP1bfq3w@mail.gmail.com>
Message-ID: <20121116230835.GR3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 11:08:47PM +0100, Joachim Eastwood wrote:
> When the atmel_open_hook/atmel_open_close assignment is dropped, these
> global variables will be useless so we should remove them as well.
> There are also some other code that uses the variables that can be
> dropped. Should shave another 22 lines of code off atmel_serial.c
> 
> I can send out a patch on top of yours if you prefer that.

Yes please.

Thanks.
