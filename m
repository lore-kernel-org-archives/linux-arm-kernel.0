From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 28 May 2014 16:35:34 -0700
Subject: [PATCHv2 15/15] misc: atmel_pwm: remove obsolete driver
In-Reply-To: <1401319218-16772-16-git-send-email-alexandre.belloni@free-electrons.com>
References: <1401319218-16772-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1401319218-16772-16-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140528233534.GA3580@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 29, 2014 at 01:20:18AM +0200, Alexandre Belloni wrote:
> The misc/atmel_pwm is not used by any mainlined boards and has been replaced by
> the pwm-driver using the generic PWM framework.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
