From: liuj97@gmail.com (Jiang Liu)
Date: Wed, 06 Nov 2013 23:10:12 +0800
Subject: [PATCH v5 1/7] arm64: introduce basic aarch64 instruction decoding
 helpers
In-Reply-To: <20131031173946.GL26009@arm.com>
References: <1382109602-27432-1-git-send-email-liuj97@gmail.com>
 <1382109602-27432-2-git-send-email-liuj97@gmail.com>
 <20131031173946.GL26009@arm.com>
Message-ID: <527A5BD4.3000405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/2013 01:39 AM, Catalin Marinas wrote:
> On Fri, Oct 18, 2013 at 04:19:55PM +0100, Jiang Liu wrote:
>> +/*
>> + * ARMv8-A Section B2.6.5:
> 
> Minor comment - please specify the document revision and the title of
> the section as they keep changing in subsequent ARMv8 ARM updates and
> this comment would no longer match.
> 
Thanks for review, will improve it in next version.
