From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 9 Nov 2012 09:12:55 +0100
Subject: [PATCH v2 04/10] pwm: pwm-tiecap: Add device-tree binding
 support for APWM driver
In-Reply-To: <20121109075219.GA22224@avionic-0098.mockup.avionic-design.de>
References: <1352361197-27442-1-git-send-email-avinashphilip@ti.com>
 <1352361197-27442-5-git-send-email-avinashphilip@ti.com>
 <20121109075219.GA22224@avionic-0098.mockup.avionic-design.de>
Message-ID: <20121109081255.GC26007@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2012 at 08:52:19AM +0100, Thierry Reding wrote:
> On Thu, Nov 08, 2012 at 01:23:11PM +0530, Philip, Avinash wrote:
[...]
> >  static int __devinit ecap_pwm_probe(struct platform_device *pdev)
> 
> __devinit can go away.
[...]
> >  static int __devexit ecap_pwm_remove(struct platform_device *pdev)
> 
> No __devexit please.
[...]
> >  	.remove = __devexit_p(ecap_pwm_remove),
> 
> No __devexit_p() please.

Okay, ignore these comments. The annotation were not added in this patch
so they can be removed in a separate patch. Or when Greg finally removes
all traces of them.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121109/8aa58abd/attachment.sig>
