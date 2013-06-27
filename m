From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 27 Jun 2013 14:03:42 +0200
Subject: [PATCH 0/5] AM33xx: MMC resources from DT without HWMOD data
In-Reply-To: <CAD=GYpbdVVrh-tiqOcbHi3mkWRJUBdx0EsEZEFVVbgFgcCWgsw@mail.gmail.com>
References: <1372209808-6532-1-git-send-email-joelagnel@ti.com>
 <CAD=GYpbdVVrh-tiqOcbHi3mkWRJUBdx0EsEZEFVVbgFgcCWgsw@mail.gmail.com>
Message-ID: <51CC2A1E.2040003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joel,

On 06/26/2013 05:28 AM, Joel A Fernandes wrote:
> On Tue, Jun 25, 2013 at 8:23 PM, Joel A Fernandes <joelagnel@ti.com> wrote:
>> From: Joel A Fernandes <agnel.joel@gmail.com>
>>
>> This series is fixes to get MMC working on AM33XX without HWMOD data.
>> On removal of HWMOD data, interrupt and register properties need to be provided
>> for the driver to function correctly.
> 
> Please don't pull patches authored by me in this series. I have posted
> them with my wrong email address by mistake. I will correct my email
> during the next repost, after a round of review. Matt's patches in the
> series are still good though.

In that case, please repost these in two series to avoid pulling the DTS
files in the MMC tree.

Thanks,
Benoit
