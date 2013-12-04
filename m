From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Dec 2013 15:44:38 -0800
Subject: [PATCH] ARM: Clean up setup printks a bit
In-Reply-To: <20131204234132.GY16735@n2100.arm.linux.org.uk>
References: <1386199826-8183-1-git-send-email-olof@lixom.net>
 <20131204234132.GY16735@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMiPfNYG_xGgnVw3Ksq4P27=qK57k-tHXn3DswtoxXEKOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 4, 2013 at 3:41 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Dec 04, 2013 at 03:30:26PM -0800, Olof Johansson wrote:
>> Clean up the setup ARM printks a bit. Add printk level to a few
>> that were missing (CPU: <...> ones, in particular), and switch from
>> printk(KERN_* ..) to pr_*().
>>
>> Finally, un-wrap some long lines since it makes it harder to grep the
>> sources from where an error came from and tweak some cases of indentation.
>
> All good stuff but you missed one :)

D'oh. Will amend and send to the tracker. Thanks!


-Olof
