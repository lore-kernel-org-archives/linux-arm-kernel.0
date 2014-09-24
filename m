From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 24 Sep 2014 17:34:36 +0800
Subject: [PATCH] misc: atmel-ssc: prepare clock only when request
In-Reply-To: <20140924090736.GC16977@sirena.org.uk>
References: <1411549019-12663-1-git-send-email-voice.shen@atmel.com>
 <20140924090736.GC16977@sirena.org.uk>
Message-ID: <5422902C.4020005@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 09/24/2014 05:07 PM, Mark Brown wrote:
> On Wed, Sep 24, 2014 at 04:56:59PM +0800, Bo Shen wrote:
>> Prepare SSC clock only when request SSC channel, the clock will be
>> enabled when initialize the SSC.
>
> You should send this to the drivers/misc maintainer.

Thanks, it has been done.

Best Regards,
Bo Shen
