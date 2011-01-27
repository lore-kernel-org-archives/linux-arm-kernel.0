From: davidb@codeaurora.org (David Brown)
Date: Thu, 27 Jan 2011 12:50:25 -0800
Subject: [PATCH] msm: Clean up useless ifdefs
In-Reply-To: <1296161064.28965.10.camel@c-dwalke-linux.qualcomm.com> (Daniel
	Walker's message of "Thu, 27 Jan 2011 12:44:24 -0800")
References: <1296159202-13980-1-git-send-email-stepanm@codeaurora.org>
	<1296161064.28965.10.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <8yaoc723wby.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27 2011, Daniel Walker wrote:

> On Thu, 2011-01-27 at 12:13 -0800, Stepan Moskovchenko wrote:
>> Remove ifdefs that do nothing, either from having the code
>> between them previously removed, or from having been
>> accidentally added to the wrong file.
>> 
>> Change-Id: I94aac2cb24e23ba7f8b4b158ce6653dc3b786989
>> Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
>
> You need to drop the Change-Id: ..

If there aren't any other concerns raised, I can pull these off when I
pull in these changes.  But, yes, in generall, they shouldn't be
present.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
