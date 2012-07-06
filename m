From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 06 Jul 2012 12:52:35 +0100
Subject: [PATCH 3/9] ARM: ux500: Remove AB8500 regulator register
 initialisation information
In-Reply-To: <20120706112317.GD4017@opensource.wolfsonmicro.com>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
 <1341493572-29735-4-git-send-email-lee.jones@linaro.org>
 <CACRpkdbRtFX8_++rndCpsH7R1uhwPrkTE_GKgNTM6r1PSuwY0A@mail.gmail.com>
 <4FF6979F.2000904@linaro.org>
 <20120706112317.GD4017@opensource.wolfsonmicro.com>
Message-ID: <4FF6D183.7040407@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/12 12:23, Mark Brown wrote:
> On Fri, Jul 06, 2012 at 08:45:35AM +0100, Lee Jones wrote:
> 
>> Please take a note of this and also do not apply the regulator
>> driver counterpart of the patch-set (it was one of the ones you
>> Reviewed-by in the previous batch).
> 
> I've no idea what patches you're talking about, sorry.

Regarding patch:
> [PATCH 08/15] regulator: Stop initialising AB8500's registers during bring-up

On 20/06/12 14:19, Lee Jones wrote:> On 20/06/12 14:08, Mark Brown wrote:
>> On Wed, Jun 20, 2012 at 01:56:44PM +0100, Lee Jones wrote:
>>> There is no need to initialise the AB8500's regulator registers, as
>>> most of this work is already carried out by framework features.
>>
>> Does this have any dependency on the rest of the series?
> 
> Unfortunately yes.
> 
> It needs the "ARM: ux500:" stuff to go in first.

Then you added your Reviewed-by: until the ux500 stuff goes in.

However, the ux500 patch has been NACKed, so please don't take the aforementioned patch in either.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515 
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
