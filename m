From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 6 Jan 2015 13:27:51 +0100
Subject: [PATCH] ASoC: sam9g20_wm8731: drop machine_is_xxx
In-Reply-To: <20150106120049.GX2634@sirena.org.uk>
References: <1420542872-10015-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150106120049.GX2634@sirena.org.uk>
Message-ID: <20150106122751.GO4194@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/01/2015 at 12:00:49 +0000, Mark Brown wrote :
> On Tue, Jan 06, 2015 at 12:14:32PM +0100, Alexandre Belloni wrote:
> > Atmel based boards can now only be used with device tree. Drop non DT
> > initialization.
> 
> This doesn't apply against current code, please check and resend.

It should apply after "sound: soc: atmel sam9g20_wm8731: remove useless
include". I was based on 3.19-rc2.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
