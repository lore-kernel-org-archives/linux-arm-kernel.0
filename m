From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 12 Dec 2013 13:19:39 +0100
Subject: regulator-core has_full_constraints set too late for dt using
 boards ?
In-Reply-To: <20131212104208.GG11044@sirena.org.uk>
References: <52A88805.1080704@redhat.com>
 <20131211160225.GB11468@sirena.org.uk> <52A98C72.2040203@redhat.com>
 <20131212104208.GG11044@sirena.org.uk>
Message-ID: <52A9A9DB.5050102@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/12/2013 11:42 AM, Mark Brown wrote:
> On Thu, Dec 12, 2013 at 11:14:10AM +0100, Hans de Goede wrote:
>> On 12/11/2013 05:02 PM, Mark Brown wrote:
>
>>> Please look at the current code, that's not how this works any more.
>
>> More current then 3.13-rc3 ? Because that is what I've been looking at.
>
> Yes, -next.  It'll be going to Linus probably this week.
>
>> I could be completely wrong of course. Either way could you give a few
>> hints as to how my interpretation of how this works is wrong ?
>
> It's correct for the code you've been looking at but has since been
> changed.  Please look at the changes in -next, you should generally
> check -next for the current state of things.

Ah yes, I see, thanks for clarifying this.

Note my patch to not do a dev_err when no regulator is found for
regulator_get_optional still is needed in -next.

Thanks & Regards,

Hans
