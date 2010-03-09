From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Tue, 09 Mar 2010 15:11:38 +0100
Subject: AC97 audio broken on SAM9263EK?
In-Reply-To: <4B8B9849.5040203@atmel.com>
References: <4B85789D.6000704@billgatliff.com>
	<4B864C66.6060209@atmel.com>	<4B867108.2050806@billgatliff.com>
	<4B86AA29.8010806@atmel.com>	<4B89E1BB.6090504@billgatliff.com>
	<4B8B9849.5040203@atmel.com>
Message-ID: <4B96571A.3040403@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-March/025709.html

I tried your patch, but mpg123 says:

Playing MPEG stream 1 of 1: 05_Tabor_Romance.mp3 ...
Title:                                   Artist:
Comment:                                 Album:
Year:                                    Genre:  Other
MPEG 1.0 layer III, 128 kbit/s, 44100 Hz stereo
[audio.c:532] error: Error in writing audio (Input/output error?)!
[mpg123.c:557] error: Deep trouble! Cannot flush to my output anymore!

I'm using kernel 2.6.33 on the at91sam9g45-ek. For sound I use patches 0039 and 0044 from
ftp://ftp.linux4sam.org/devel/linux/2630_lnx4sam_patchset-tmp_20090828.tgz. With these I get proper sound from my head phones.

Regards,
Yegor
