From: segher@kernel.crashing.org (Segher Boessenkool)
Date: Wed, 22 Jun 2011 00:52:47 +0200
Subject: [PATCH 1/3] serial/imx: add device tree support
In-Reply-To: <BANLkTikBUo3jO=R0amkdxU1V3QMJoOUkEw@mail.gmail.com>
References: <1308410354-21387-1-git-send-email-shawn.guo@linaro.org>
	<1308410354-21387-2-git-send-email-shawn.guo@linaro.org>
	<20110618161934.GH8195@ponder.secretlab.ca>
	<20110619073000.GA23171@S2100-06.ap.freescale.net>
	<20110621135558.GB9228@S2101-09.ap.freescale.net>
	<BANLkTim4vunTm1176MRw3pqRZnunu4=9jg@mail.gmail.com>
	<4E00F290.2010303@firmworks.com>
	<BANLkTik9LXTJ--fRwUBscokWraPwOZnpHA@mail.gmail.com>
	<4E011678.4030208@firmworks.com>
	<BANLkTikBUo3jO=R0amkdxU1V3QMJoOUkEw@mail.gmail.com>
Message-ID: <ba379b3b42f1659f4f6649c78b8bb1b2@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Ah, we're having an impedance mismatch.  I'm thinking specifically
> about the device tree compiler and some syntactic sugar for using the
> label definition to generate /also/ create alias properties. The
> hairiness is related to that and the way that dtc is implemented, not
> with the final aliases themselves.

You can generate DTC-style aliases from OFW-style aliases instead (or
as well), it has other advantages (like being more readable, and having
the aliases grouped together).


Segher
