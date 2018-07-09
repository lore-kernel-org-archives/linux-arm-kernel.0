From: sre@kernel.org (Sebastian Reichel)
Date: Mon, 9 Jul 2018 23:49:10 +0200
Subject: Vibrations on Droid 4?
In-Reply-To: <20180709081534.GA6799@amd>
References: <20180709081534.GA6799@amd>
Message-ID: <20180709214910.tes6u4ivxomd3aja@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 09, 2018 at 10:15:35AM +0200, Pavel Machek wrote:
> Do you have vibrations on d4 working?
> I believe I have required drivers enabled, but no luck:
> 
> user at devuan:/sys/bus/platform/drivers$ ls pwm-vibrator/
> bind  uevent  unbind
> user at devuan:/sys/bus/platform/drivers$ ls omap-dmtimer-pwm/
> bind  uevent  unbind

Have you checked probe deferrals?

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180709/503b6d6a/attachment.sig>
