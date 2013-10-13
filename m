From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 13 Oct 2013 20:29:47 +0200
Subject: [PATCH RESEND 0/3] ARM: S3C24XX: add missing dma-devices and
 warning fix
In-Reply-To: <20131012123329.GL2443@sirena.org.uk>
References: <201310111059.19791.heiko@sntech.de> <15184009.9QsSDOGPSA@amdn883>
 <20131012123329.GL2443@sirena.org.uk>
Message-ID: <4125349.GMtWWSIflF@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 of October 2013 13:33:29 Mark Brown wrote:
> On Sat, Oct 12, 2013 at 06:36:36AM +0200, Tomasz Figa wrote:
> > Big thanks for this series and the one adding DMA engine support for
> > S3C24xx. It would be great if someone could test this on affected
> > platforms, so we could finally drop the old S3C-DMA nonsense.
> 
> Did the s3c64xx pl08x stuff get merged?

Most of. All the patches for the amba-pl08x driver got merged. Just the 
platform glue remains. I will rebase and send respective patches this 
week.

Best regards,
Tomasz
