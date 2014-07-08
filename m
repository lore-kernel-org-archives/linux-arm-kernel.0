From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 08 Jul 2014 15:56:14 +0300
Subject: [PATCH v3] s3cmci: port DMA code to dmaengine API
In-Reply-To: <CAPDyKFoVtJLyBrjwyQYKK6h=8aNd7+SMYU9bS8iStcSZkWs3Fw@mail.gmail.com>
References: <1401643329-6460-1-git-send-email-anarsoul@gmail.com>
 <201407072312.40687.arnd@arndb.de>
 <CAPDyKFoVtJLyBrjwyQYKK6h=8aNd7+SMYU9bS8iStcSZkWs3Fw@mail.gmail.com>
Message-ID: <2209409.5C7y4zWhxp@vasilykh-desktop-i5>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 July 2014 14:51:01 Ulf Hansson wrote:

> Sorry for the delay.
> 
> Thanks! Applied for next with Arnd's ack.
> 
> Kind regards
> Uffe

Thank you!

And since now old s3c24xx DMA (non-dmaengine) has no users we can remove it 
completely.

I'll send a patch soon.

Regards
Vasily
