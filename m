From: wg@grandegger.com (Wolfgang Grandegger)
Date: Fri, 14 Dec 2012 18:58:03 +0100
Subject: [PATCH RESEND 0/6 v10] gpio: Add block GPIO
In-Reply-To: <1355495185-24220-1-git-send-email-stigge@antcom.de>
References: <1355495185-24220-1-git-send-email-stigge@antcom.de>
Message-ID: <50CB68AB.5070806@grandegger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2012 03:26 PM, Roland Stigge wrote:
> This set of patches adds:
> 
> * Block GPIO API to gpiolib
> * Sysfs support for GPIO API, to provide userland access
> * Device interface for userland access (alternative to sysfs)
> * Devicetree support to instantiate GPIO blocks via DT
> * Example implementations in several gpio drivers since they need
>   special accessor functions for block wise GPIO access
> * Fix for race condition in gpiolib on device creation
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Tested by: Wolfgang Grandegger <wg@grandegger.com>

I'm going to re-test this version next week. Attached you will find my
GPIO block adoptions for the AT91.

Wolfgang

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-gpio-add-GPIO-block-callback-functions-for-AT91.patch
Type: text/x-diff
Size: 2721 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121214/29dc065d/attachment-0001.bin>
