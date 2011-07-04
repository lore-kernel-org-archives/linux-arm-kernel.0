From: michael@walle.cc (Michael Walle)
Date: Mon, 4 Jul 2011 22:50:42 +0200
Subject: [PATCH v2] ARM: kirkwood: Add support for Buffalo LS-XHL
In-Reply-To: <BANLkTim-qB+ArwxX0o8dAqU3--Uex4TWBw@mail.gmail.com>
References: <1307655488-12811-1-git-send-email-michael@walle.cc>
	<1307655488-12811-2-git-send-email-michael@walle.cc>
	<BANLkTim-qB+ArwxX0o8dAqU3--Uex4TWBw@mail.gmail.com>
Message-ID: <201107042250.42500.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag 30 Juni 2011, 22:58:15 schrieb Bj?rn Forsman:
> Hi Michael,
[..]
> So, the power switch also seem to suffer from some interrupt overload;
> 10154532 IRQs for Power-auto Switch is not right...right?
> 
> Have you seen this behaviour?
Nope, the interrupt behaves normally for me. But i'm running this patch with 
kernel 2.6.32 and tested it briefly with 2.6.39.

Could you verify, if you are triggering the bug Simon posted above?

-- 
Michael
