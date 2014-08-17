From: carlo@caione.org (Carlo Caione)
Date: Sun, 17 Aug 2014 17:25:49 +0200
Subject: [PATCH 0/7] ARM: meson: add preliminary support for MesonX/Meson6
 SoCs
In-Reply-To: <20140817142912.GA29963@gmail.com>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <20140817142912.GA29963@gmail.com>
Message-ID: <CAOQ7t2bdBqS=AdhqYZdNeqygF_RB9tKMJ_y3XtpA7z6XbJsKXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 17, 2014 at 4:29 PM, Beniamino Galvani <b.galvani@gmail.com> wrote:

> nice job! The patches work fine on a Tronsmart Vega S89 Elite TV box
> (Meson8 S802 SoC) just changing the fixed-clock frequency in the dts.

This means that probably also the timer driver can be somehow shared
between Meson6 and Meson8. If this is confirmed in v2 I can make a
generic clocksource/clockevents driver for both the architectures.

Thanks,

-- 
Carlo Caione
