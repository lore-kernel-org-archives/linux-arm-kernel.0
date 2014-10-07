From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 7 Oct 2014 09:23:06 -0700
Subject: [PATCH 29/44] staging: nvec: Register with kernel poweroff handler
In-Reply-To: <1412659726-29957-30-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-30-git-send-email-linux@roeck-us.net>
Message-ID: <20141007162306.GA2913@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 10:28:31PM -0700, Guenter Roeck wrote:
> Register with kernel poweroff handler instead of setting pm_power_off
> directly. Register with default priority value of 128 since we don't know
> any better.
> 
> Cc: Julian Andres Klode <jak@jak-linux.org>
> Cc: Marc Dietrich <marvin24@gmx.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/staging/nvec/nvec.c | 24 +++++++++++++++---------
>  drivers/staging/nvec/nvec.h |  2 ++
>  2 files changed, 17 insertions(+), 9 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
