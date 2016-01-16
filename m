From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sun, 17 Jan 2016 00:27:38 +0100
Subject: Nokia N900: annoying yellow LED while battery is charging (and
 some progress with free userspace)
In-Reply-To: <20160116232222.GB10962@amd>
References: <20160116232222.GB10962@amd>
Message-ID: <201601170027.38572@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 17 January 2016 00:22:22 Pavel Machek wrote:
> Hi!
> 
> While battery is charging, 3 color LED produces yellow light.. at
> quite high intensity, which makes screen unpleasant to look at (with
> 4.4 kernel).
> 
> I'm pretty sure original Maemo did not try to blind me.
> 
> It looks like CHRG_IND signal goes from charger to LEDs, and
> BOOT_MODE pin may be involved.
> 
> Any idea how to get rid of the light?

echo 0 > /sys/class/power_supply/bq24150a-0/stat_pin_enable

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160117/46ca50a3/attachment.sig>
