From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 Sep 2014 20:37:31 +0200
Subject: Differences between tlv320aic3x and tlv320aic31xx
Message-ID: <20140930183731.GC3907@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm trying to add support for the tlv320aic3104a present on a
custom board using an am335x.

I see that Benoit seemed to have been successful when using the
tlv320aic3x driver with minor modifications.
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-January/058966.html

On the other hand, in the past, I've used a tlv320aic3100 with the
tlv320aic31xx driver.

My plan for now is to use the tlv320aic3x driver with snd-soc-evm as
this is the one it is using (it is using .codec_dai_name =
"tlv320aic3x-hifi").

I had no luck until now but I still have to review my pinmuxing. But
before I investigate to much, can you confirm what codecs are supported
by which driver? I'm pretty sure that would be a nice addition to the
documentation too.

Thanks,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
