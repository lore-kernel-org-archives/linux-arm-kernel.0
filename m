From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 3 Dec 2013 10:45:37 -0800
Subject: [PATCH 03/15] serial: sh-sci: Restrict non-COMPILE_TEST
 compilation
In-Reply-To: <1385515117-23664-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385515117-23664-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20131203184537.GE23280@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 02:18:25AM +0100, Laurent Pinchart wrote:
> Hardware supported by the driver is only found on SUPERH or
> ARCH_SHMOBILE platforms. Restrict non-COMPILE_TEST compilation to them.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial at vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/tty/serial/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
