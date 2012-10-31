From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 31 Oct 2012 16:04:55 +0100
Subject: [PATCH RESEND 3/5 v6] gpiolib: Fix default attributes for class
In-Reply-To: <1351457210-25222-4-git-send-email-stigge@antcom.de>
References: <1351457210-25222-1-git-send-email-stigge@antcom.de>
 <1351457210-25222-4-git-send-email-stigge@antcom.de>
Message-ID: <CACxGe6uNhQgG+p6iO47oWSWiDvuYQtj1x62nrTzHGPr02dj_5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 28, 2012 at 9:46 PM, Roland Stigge <stigge@antcom.de> wrote:
> There is a race condition between creating a gpio or gpiochip device and adding
> default attributes. This patch fixes this by defining the default attributes as
> dev_attrs of the class. For this, it was necessary to create a separate
> gpiochip_class besides gpio_class.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

This looks right, but I need to test it....

g.
