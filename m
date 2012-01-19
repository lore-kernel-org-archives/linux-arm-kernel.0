From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 19 Jan 2012 11:29:41 +0000
Subject: mc13xxx: add I2C support
In-Reply-To: <87lip4kktc.fsf@lebrac.rtp-net.org>
References: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au>
 <87lip4kktc.fsf@lebrac.rtp-net.org>
Message-ID: <20120119112941.GC29494@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 12:12:31PM +0100, Arnaud Patard wrote:

> I've never looked at regmap deeply but can't it be done with regmap or is it
> just a bad idea ?

Glancing quickly at the existing code it should map on reasonably well,
though a new format definition may be required for the 25 bit shift that
would be trivial.
