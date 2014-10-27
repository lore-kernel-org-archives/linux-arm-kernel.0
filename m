From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 27 Oct 2014 11:32:40 +0100
Subject: [PATCH v4 2/3] regulator: max77686: Implement suspend disable
 for some LDOs
In-Reply-To: <1414405641.1674.1.camel@AMDC1943>
References: <1414403066-7872-1-git-send-email-k.kozlowski@samsung.com>
 <1414403066-7872-3-git-send-email-k.kozlowski@samsung.com>
 <544E19A4.6040603@collabora.co.uk> <1414405641.1674.1.camel@AMDC1943>
Message-ID: <544E1F48.9050105@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 11:27 AM, Krzysztof Kozlowski wrote:
> 
> Storing opmode in non-shifted form is intuitive also to me. That's way I
> slipped the bug in previous version.
> 

Great.

> I'll change this to non-shifted opmode. The patch will grow bigger but
> the code should be more readable.
> 

Maybe split in two patches? A preparatory that adds max77686_get_opmode_shift()
and changes the current driver and a second one that implements suspend disable
for LDOs?

> Thanks!

You are welcome.

Best regards,
Javier
