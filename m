From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 27 Oct 2012 10:51:23 +0200
Subject: [PATCH 6/9] ARM: Kirkwood: Convert GoFlex Net to pinctrl.
In-Reply-To: <CAMW5UfZ9KiDX=XHApvTGC=Um+RX-h8ZsvOVVwHyLH7cW==Qy7g@mail.gmail.com>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <1351090434-30499-7-git-send-email-andrew@lunn.ch>
 <CAMW5UfZ9KiDX=XHApvTGC=Um+RX-h8ZsvOVVwHyLH7cW==Qy7g@mail.gmail.com>
Message-ID: <20121027085123.GB15143@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 01:28:08PM -0400, Josh Coombs wrote:
> Initial test with my 3.7-rc2 DT kernel config failed when it tried to
> build modules:
> 
>   Building modules, stage 2.
>   MODPOST 733 modules
> ERROR: "read_current_timer" [drivers/video/udlfb.ko] undefined!
> ERROR: "read_current_timer" [crypto/tcrypt.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> I didn't realize my play kernel test package still includes the
> following patch, I thought it had been dealt with already.  Should I
> start a new thread on this issue?

Hi Josh

It is a known issue which i've seen discussed on the lists. I expect
it to be fixed soon.

   Andrew
