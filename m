From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 27 Jan 2010 11:06:01 +0000
Subject: [Rev2]Samsung: New driver for AC97 controllers
In-Reply-To: <1264571815-14893-1-git-send-email-jassisinghbrar@gmail.com>
References: <1264571815-14893-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <20100127110600.GG22551@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 02:56:55PM +0900, jassisinghbrar at gmail.com wrote:

>  I am going to submit revised patches for new driver for the AC97-ver-2.0
> controllers found in Samsung SoCs. The driver is named generic s3c-ac97.c
>  The driver has been tested for on s3c64xx and newer SoCs and is confirmed
> to support Playback/Capture and VRA.

The ASoC bits of this all look good, I'll do some testing before I apply
them though (probably later today) since I have relevant hardware on my
desk.
