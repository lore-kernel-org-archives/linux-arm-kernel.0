From: javier.martin@vista-silicon.com (javier Martin)
Date: Wed, 18 May 2011 12:34:09 +0200
Subject: [PATCH 1/2] mt9p031: Add mt9p031 sensor driver.
In-Reply-To: <201105171414.34179.ivan.nazarenko@gmail.com>
References: <1305624528-5595-1-git-send-email-javier.martin@vista-silicon.com>
	<Pine.LNX.4.64.1105171345580.5582@axis700.grange>
	<BANLkTinR3g7DcXLqOngw8kkNc-LLysFX=w@mail.gmail.com>
	<201105171414.34179.ivan.nazarenko@gmail.com>
Message-ID: <BANLkTimCZm5-mtLfCn-_s1EVcL6DxaqC-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ivan,

On 17 May 2011 19:14, Ivan Nazarenko <ivan.nazarenko@gmail.com> wrote:
> Javier,
>
> I have been using the aptina patch (https://github.com/Aptina/BeagleBoard-xM) on beagleboard while waiting linux-media solve this mt9p031 issue. Now that you have something working, I would like to try it - but I would like to know what is the clock rate you actually drove the sensor.
>
> Reviewing your path, I suppose it is 54MHz, so you would be achieving some 10 full 5MPix frames/s from the sensor. Is that correct? (the aptina patch delivers less than 4 fps).
>

Yes, you are right. Whereas clock rate is set to 54MHz, with my
oscilloscope I have measured 57 MHz.


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
