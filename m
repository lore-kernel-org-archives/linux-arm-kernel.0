From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 20 May 2015 12:18:13 +0200
Subject: [RFC PATCH 1/4] spi: spidev: Add Google SPI flash compatible
 string
In-Reply-To: <20150520101318.GB21577@sirena.org.uk>
References: <1432042454-19234-1-git-send-email-javier.martinez@collabora.co.uk>
 <1432042454-19234-2-git-send-email-javier.martinez@collabora.co.uk>
 <20150520101318.GB21577@sirena.org.uk>
Message-ID: <555C5F65.7010204@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 05/20/2015 12:13 PM, Mark Brown wrote:
> On Tue, May 19, 2015 at 03:34:11PM +0200, Javier Martinez Canillas wrote:
>> Google Chromebooks have a SPI flash that is used to store firmware and
>> different system parameters and data (i.e: Google Binary Block flags).
> 
>> ---
>>  drivers/spi/spidev.c | 1 +
>>  1 file changed, 1 insertion(+)
> 
> This is adding a binding with no documentation, documentation is
> mandatory for all bindings.
> 

Yes, I missed... sorry about that. Do you agree with the approach
though so I can re-spin the patches adding the missing DT binding?

Best regards,
Javier
