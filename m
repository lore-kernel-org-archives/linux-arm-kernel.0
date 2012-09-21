From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 21 Sep 2012 16:05:53 -0700
Subject: [RFC 3/3] ARM/AVR32: get rid of serial_at91.h
In-Reply-To: <E1TEzfE-000780-1t@rmk-PC.arm.linux.org.uk>
References: <20120921093530.GB31374@n2100.arm.linux.org.uk>
 <E1TEzfE-000780-1t@rmk-PC.arm.linux.org.uk>
Message-ID: <20120921230553.GF4918@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 10:36:48AM +0100, Russell King wrote:
> The definitions provided by serial_at91.h are only used by the
> atmel_serial driver, and the function that uses it is never called
> from anywhere in the kernel.  Therefore, these definitions are unused
> and/or obsolete, and can be removed.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
