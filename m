From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 11 Jan 2012 17:42:16 +0000
Subject: [PATCH 06/11] ep93xx: Don't use system controller defines in
 audio drivers
In-Reply-To: <1326251676-7593-7-git-send-email-rmallon@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
 <1326251676-7593-7-git-send-email-rmallon@gmail.com>
Message-ID: <20120111174216.GD24213@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 02:14:31PM +1100, Ryan Mallon wrote:
> Both the Snapper CL15 and EDB93xx audio drivers set the same audio
> configuration in ep93xx_i2s_acquire. Remove the arguments to
> ep93xx_i2s_acquire so that the audio drivers no longer need the
> EP93XX_SYSCON defines exported.

What if there are other boards out there which use a different
configuration?
