From: rogerq@ti.com (Roger Quadros)
Date: Mon, 5 May 2014 17:02:40 +0300
Subject: [PATCH] ARM: OMAP4: hwmod: Fix SOFTRESET logic for OMAP4
In-Reply-To: <alpine.DEB.2.02.1402191752590.8777@utopia.booyaka.com>
References: <1391612769-27890-1-git-send-email-illia.smyrnov@globallogic.com>
 <alpine.DEB.2.02.1402191752590.8777@utopia.booyaka.com>
Message-ID: <53679A00.70803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Illia,

On 02/19/2014 07:53 PM, Paul Walmsley wrote:
> On Wed, 5 Feb 2014, Illia Smyrnov wrote:
> 
>> Commit 313a76e (ARM: OMAP2+: hwmod: Fix SOFTRESET logic) introduced
>> softreset bit cleaning right after set one. It is caused L3 error for
>> OMAP4 ISS because ISS register write occurs when ISS reset process is in
>> progress. Avoid this situation by cleaning softreset bit later, when reset
>> process is successfully finished.
>>
>> Signed-off-by: Illia Smyrnov <illia.smyrnov@globallogic.com>
> 
> Thanks, queued for v3.14-rc with notations from Grygorii and Roger.
> 

This hasn't made it to the stable kernels yet.

Could you please send commit 01142519ffc0 to stable at vger.kernel.org for
v3.4+ kernels? Thanks.

cheers,
-roger
