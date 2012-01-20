From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 20 Jan 2012 11:36:59 -0600
Subject: [PATCH] ARM: move CP15 definitions to separate header file
In-Reply-To: <E1RoBJw-0005UP-By@rmk-PC.arm.linux.org.uk>
References: <E1RoBJw-0005UP-By@rmk-PC.arm.linux.org.uk>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3F9D06870@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, January 20, 2012 3:04 AM, Russell King wrote:
> Avoid namespace conflicts with drivers over the CP15 definitions by
> moving CP15 related prototypes and definitions to a private header
> file.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

For EP93xx,

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
