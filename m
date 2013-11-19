From: jsarha@ti.com (Jyri Sarha)
Date: Tue, 19 Nov 2013 15:29:26 +0200
Subject: [PATCH RFC] ARM/dts: am335x-boneblack: Add HDMI audio support
In-Reply-To: <528B617A.4080102@baylibre.com>
References: <cover.1384863282.git.jsarha@ti.com>
 <18d71a32fb46d34197fd2e0ec5dc8ebc36371704.1384863282.git.jsarha@ti.com>
 <528B617A.4080102@baylibre.com>
Message-ID: <528B67B6.6040706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2013 03:02 PM, Benoit Cousson wrote:
> A side question related to audio cape support on BBB. In the "official"
> 3.8.13 CircuitCo version the HDMI audio support was breaking the
> audio-cape support due to some bad hacks in the mcasp driver.
>
> Is this still the case with you series?

My patches do not touch davinci-mcasp at all and the davinci-evm changes 
should be backwards compatible. So if the audio-cape was working before 
my patches should not break it.

Best regards,
Jyri
