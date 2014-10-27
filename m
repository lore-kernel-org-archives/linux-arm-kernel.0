From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 27 Oct 2014 11:35:35 +0100
Subject: [PATCH v4 2/3] regulator: max77686: Implement suspend disable for
 some LDOs
In-Reply-To: <544E1F48.9050105@collabora.co.uk>
References: <1414403066-7872-1-git-send-email-k.kozlowski@samsung.com>
 <1414403066-7872-3-git-send-email-k.kozlowski@samsung.com>
 <544E19A4.6040603@collabora.co.uk> <1414405641.1674.1.camel@AMDC1943>
 <544E1F48.9050105@collabora.co.uk>
Message-ID: <1414406135.1674.2.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pon, 2014-10-27 at 11:32 +0100, Javier Martinez Canillas wrote:
> On 10/27/2014 11:27 AM, Krzysztof Kozlowski wrote:
> > 
> > Storing opmode in non-shifted form is intuitive also to me. That's way I
> > slipped the bug in previous version.
> > 
> 
> Great.
> 
> > I'll change this to non-shifted opmode. The patch will grow bigger but
> > the code should be more readable.
> > 
> 
> Maybe split in two patches? A preparatory that adds max77686_get_opmode_shift()
> and changes the current driver and a second one that implements suspend disable
> for LDOs?

Yes, that was the plan :).

> 
> > Thanks!
> 
> You are welcome.
> 
> Best regards,
> Javier
