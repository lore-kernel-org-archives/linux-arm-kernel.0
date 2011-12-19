From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 19 Dec 2011 09:59:36 +0100
Subject: [PATCH 08/14] mmc: mmci: Fixup error handling for dma
In-Reply-To: <20111218231614.GB14542@n2100.arm.linux.org.uk>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
 <1323106560-5218-9-git-send-email-ulf.hansson@stericsson.com>
 <20111218231614.GB14542@n2100.arm.linux.org.uk>
Message-ID: <4EEEFCF8.2060806@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Dec 05, 2011 at 06:35:54PM +0100, Ulf Hansson wrote:
>> When getting a cmd irq during an ongoing data transfer
>> with dma, the dma job were never terminated. This is now
>> corrected.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>> Signed-off-by: Per Forlin <per.forlin@stericsson.com>
> 
> I've queued this up in my 'fixes' branch with a Cc to the stable team
> for previous kernels.  I believe this to be appropriate.  Please confirm.
> 

Great!

BR
Ulf Hansson
