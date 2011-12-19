From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 19 Dec 2011 09:59:11 +0100
Subject: [PATCH 02/14] mmc: mmci: Fixup handling of MCI_STARTBITERR
In-Reply-To: <20111218231534.GA14542@n2100.arm.linux.org.uk>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
 <1323106560-5218-3-git-send-email-ulf.hansson@stericsson.com>
 <20111218231534.GA14542@n2100.arm.linux.org.uk>
Message-ID: <4EEEFCDF.5030304@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Dec 05, 2011 at 06:35:48PM +0100, Ulf Hansson wrote:
>> The interrupt was previously enabled and then correctly cleared.
>> Now we also handle it correctly.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I've queued this in my 'fixes' branch with a Cc to the stable team for
> previous kernel versions.  I believe that to be appropriate.  Please
> confirm.
> 

Great!

BR
Ulf Hansson
