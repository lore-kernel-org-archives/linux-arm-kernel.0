From: zonque@gmail.com (Daniel Mack)
Date: Sun, 29 Jul 2012 21:05:59 +0200
Subject: [PATCH v3 9/9] ARM: pxa: add .dtsi files
In-Reply-To: <1343470061-16879-10-git-send-email-zonque@gmail.com>
References: <1343470061-16879-1-git-send-email-zonque@gmail.com>
 <1343470061-16879-10-git-send-email-zonque@gmail.com>
Message-ID: <50158997.6020903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.07.2012 12:07, Daniel Mack wrote:
> This adds .dtsi files to describe the PXA SoCs. pxa3xx simply augments
> pxa2xx. Not all devices are listed yet, and it will need some time to
> get all the drivers ported.

Here's a new version of that patch which adds pxa27x.dtsi and enables
the interrupt priority features of pxa3xx and pxa27x.

Haojian, is it ok to send the updates inline or would you prefer a new
series? Or a branch to pull from?


Daniel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-pxa-add-.dtsi-files.patch
Type: text/x-patch
Size: 5061 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120729/f3f08537/attachment.bin>
