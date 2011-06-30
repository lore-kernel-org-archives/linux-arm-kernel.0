From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 30 Jun 2011 08:22:07 -0700
Subject: [PATCH 1/5] ASoC: wm8731: rework power management
In-Reply-To: <4E0C80B8.7030006@atmel.com>
References: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>
	<ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
	<20110629171148.GB10798@opensource.wolfsonmicro.com>
	<4E0C80B8.7030006@atmel.com>
Message-ID: <20110630152203.GB3249@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 03:57:12PM +0200, Nicolas Ferre wrote:

Please fix your mailer to line wrap within paragraphs.

> First of all, I experienced issues while not having OSC enabled during
> suspend/resume cycle. Am I right supposing that, if using oscillator
> to clock the codec, I have to keep it running during a suspend/resume
> cycle?

No, not at all.  What makes you believe that you would you need to do
that?
