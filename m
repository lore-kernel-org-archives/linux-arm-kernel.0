From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 24 Feb 2012 07:48:51 +0100
Subject: [PATCH v3 06/10] pwm: Add NVIDIA Tegra SoC support
In-Reply-To: <4F460616.3080400@gmail.com>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <1329923841-32017-7-git-send-email-thierry.reding@avionic-design.de>
 <4F459A94.4030104@gmail.com>
 <20120223081459.GD8621@avionic-0098.mockup.avionic-design.de>
 <4F460616.3080400@gmail.com>
Message-ID: <20120224064851.GC18786@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ryan Mallon wrote:
> On 23/02/12 19:14, Thierry Reding wrote:
> > * Ryan Mallon wrote:
[...]
> >> pwmchip_add should probably verify that the initialisation of the
> >> pwm_chip structure is sane to avoid problems like this.
> > 
> > Absolutely. What would be the best response to an invalid struct pwm_chip? I
> > suppose at least returning -EINVAL, perhaps complemented with WARN_ON?
> 
> Just returning -EINVAL should be okay. I don't think you need a WARN_ON,
> since failing to register the hardware should be enough of a reason for
> a user to report a problem.

Okay, will do.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120224/2036d092/attachment.sig>
