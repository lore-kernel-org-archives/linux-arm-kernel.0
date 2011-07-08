From: robherring2@gmail.com (Rob Herring)
Date: Fri, 08 Jul 2011 12:59:47 -0500
Subject: [PATCH v4 2/2] ARM: l2x0: Add OF based initialization
In-Reply-To: <201107062326.53737.arnd@arndb.de>
References: <1309984979-8847-1-git-send-email-robherring2@gmail.com>
	<1309984979-8847-2-git-send-email-robherring2@gmail.com>
	<20110706210237.GB5371@ponder.secretlab.ca>
	<201107062326.53737.arnd@arndb.de>
Message-ID: <4E174593.20107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 07/06/2011 04:26 PM, Arnd Bergmann wrote:
> On Wednesday 06 July 2011 23:02:37 Grant Likely wrote:
>>
>> On Wed, Jul 06, 2011 at 03:42:59PM -0500, Rob Herring wrote:
>>> From: Rob Herring <rob.herring@calxeda.com>
>>>
>>> This adds probing for ARM L2x0 cache controllers via device tree. Support
>>> includes the L210, L220, and PL310 controllers. The binding allows setting
>>> up cache RAM latencies and filter addresses (PL310 only).
>>>
>>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>>
>> By rights, this should go via the arm tree, but it depends on patches
>> that are already in devicetree/next.  Arnd, how do you want to handle
>> this?  I want to avoid rebasing devicetree/next.
> 
> It's outside of the scope of the arm-soc tree really, the l2x0 code
> is clearly core arm stuff, so it belongs into Russell's tree.
> 
> I think it's best if Russell can provide an Ack for this and you
> put it in the tree that already has the dependencies.
> 

Any comments?

Rob
