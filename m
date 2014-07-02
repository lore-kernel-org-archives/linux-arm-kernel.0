From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Wed, 02 Jul 2014 16:59:50 +0100
Subject: drm/i2c: tda998x: Set CEC I2C address from TDA I2C address
In-Reply-To: <20140702153418.GM32514@n2100.arm.linux.org.uk>
References: <53B3D1F8.7080106@arm.com>
 <20140702102513.GF32514@n2100.arm.linux.org.uk> <53B3E2E4.20209@arm.com>
 <20140702153418.GM32514@n2100.arm.linux.org.uk>
Message-ID: <53B42C76.6060104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/14 16:34, Russell King - ARM Linux wrote:
> On Wed, Jul 02, 2014 at 11:45:56AM +0100, Andrew Jackson wrote:
>> On 07/02/14 11:25, Russell King - ARM Linux wrote:
>>> On Wed, Jul 02, 2014 at 10:33:44AM +0100, Andrew Jackson wrote:

> Thanks, that's useful information to have.  Also, it's worth pointing out
> that the patch is whitespace damaged - tabs are converted to spaces,
> which makes it unable to be applied.  There's other reasons (see below)
> that makes us unable to apply this patch too...
> 
> As we all know, email clients know better than us humans how to format
> email messages, which gives them carte blanche to screw up patches in
> this way.
> 
> I'd recommend that you talk to others in ARM Ltd about how they get
> around this problem.
> 
>> -- IMPORTANT NOTICE: The contents of this email and any attachments
>> are confidential and may also be privileged. If you are not the
>> intended recipient, please notify the sender immediately and do
>> not disclose the contents to any other person, use it for any
>> purpose, or store or copy the information in any medium.  Thank you.
> 
> This means that I can't take the patch, since applying it into a git
> tree and then publishing it would violate this statement.  Doing so
> copies and stores the information, and makes it available to people
> who were not the intended recipient of your email.
> 

Indeed.  I've now defeated the signature issue, or so I assert, so I will re-submit a clean version of the patch with additional documentation regarding the information on the various TDA998x devices.

Thank you for your tolerance.

   Andrew
