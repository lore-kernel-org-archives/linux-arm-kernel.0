From: lost.distance@yahoo.com (Paul Parsons)
Date: Sun, 23 Sep 2012 16:20:24 +0100
Subject: PXA PWM possible regression after 3.5: backlight remains off after
 resume
Message-ID: <505F28B8.1030701@yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a possible PXA PWM regression between 3.5 and 3.6-rc6: if I
suspend and then resume an iPAQ hx4700, the backlight remains off.

In 3.5 the backlight would turn on after the resume.

I presumed this is a PWM issue because the PXA PWM driver was reworked
and moved trees between 3.5 and 3.6-rc6. And there was mention of
broken PWM drivers about a month ago, for example:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/115717.html

Does my backlight breakage sound familiar to anybody? Is there
anything obvious I can try before debugging it further?

Regards,
Paul
