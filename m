From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Feb 2016 11:02:03 +0000
Subject: [PATCH v3 00/12] pwm: add support for atomic update
In-Reply-To: <CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <2341981.a79ioYM9Es@diego> <20151110173416.GB21727@ulmo>
 <CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
 <20160125170855.GA10182@ulmo>
 <CAD=FV=Xvxeqo3imUmjukC5iYk3EZkrJ04G7C1B-w4xyr-r6-2Q@mail.gmail.com>
 <20160203145337.GD9650@ulmo>
 <CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
Message-ID: <20160204110203.GL4455@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 11:04:20AM -0800, Doug Anderson wrote:

> Sure.  ...but you agree that somehow you need a new API call for this,
> right?  Somehow the PWM regulator needs to be able to say that it
> wants the hardware state, not the initial state as specified in the
> device tree.

Wouldn't the most direct way to do that be to just not specify anything
in the DT?  If there *is* something in DT but we ignore it that's a bit
weird.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160204/3d4f608e/attachment-0001.sig>
