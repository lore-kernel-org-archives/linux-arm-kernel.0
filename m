From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 7 Aug 2013 16:08:06 +0800
Subject: [RFC PATCH] clock: correct the comparison parameter of MHz
In-Reply-To: <20130807080253.GE23006@n2100.arm.linux.org.uk>
References: <1375861660-32525-1-git-send-email-voice.shen@atmel.com>
 <20130807080253.GE23006@n2100.arm.linux.org.uk>
Message-ID: <52020066.3050500@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,

On 8/7/2013 16:02, Russell King - ARM Linux wrote:
> On Wed, Aug 07, 2013 at 03:47:40PM +0800, Bo Shen wrote:
>> correct the comparison parameter of MHz from 4,000,000 to 1,000,000
>
> You're assuming this wasn't intentional.  As the division by 1000000
> ends up losing the fractional rate, I decided to leave 1-4MHz as kHz,
> so something like 1.832MHz would be displayed as 1832kHz and not
> 1MHz.

Thanks for clarification of this. Now, it is better for me to understand 
this piece of code.

Best Regards,
Bo Shen
