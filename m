From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 10 Jun 2016 16:04:04 +0200
Subject: [PATCH v3 10/20] pwm: sysfs: Add PWM Capture support
In-Reply-To: <20160608092135.21184-11-lee.jones@linaro.org>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-11-lee.jones@linaro.org>
Message-ID: <20160610140404.GL27142@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 10:21:25AM +0100, Lee Jones wrote:
> Allow a user to read PWM Capture results from /sysfs.
> 
> To start a capture and read the result, simply read the file:
> 
>   $ cat $PWMCHIP/capture
> 
> The output format is "<period>:<duty_cycle>".

The format below is "<period> <duty cycle>".

No need to rev the series for this, I can take patches 8 and 10 as-is
and make those modifications myself.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/46ef8ad1/attachment.sig>
