From: robertcnelson@gmail.com (Robert Nelson)
Date: Wed, 29 May 2013 15:41:02 -0500
Subject: [PATCH v3 0/5] rtc-at91rm9200: add shadow interrupt mask
In-Reply-To: <20130529133354.dd181c845ee4e96527483345@linux-foundation.org>
References: <1364983415-20298-1-git-send-email-jhovold@gmail.com>
 <1369298335-24597-1-git-send-email-jhovold@gmail.com>
 <20130529133354.dd181c845ee4e96527483345@linux-foundation.org>
Message-ID: <CAOCHtYiK8Y6iTnb4dWAE+cKHqEta-64gj+PorSFVGBF5wmg1+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 3:33 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Thu, 23 May 2013 10:38:50 +0200 Johan Hovold <jhovold@gmail.com> wrote:
>
>> This is an update of the shadow-interrupt-mask series against v3.10-rc2.
>>
>> I guess we need Atmel to confirm that all sam9x5 SoCs are indeed
>> affected. If not, then some probing mechanism as the one Doug suggested
>> could be implemented on top of (a subset of) these patches. What do you
>> say, Nicolas?
>>
>> Note that the first patch (adding a missing OF compile guard) could be
>> applied straight away.
>
> At this stage it is unclear to me how to proceed with patches 2-5.

fyi:

A version of these patches had been applied once before:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=0ef1594c017521ea89278e80fe3f80dafb17abde

But due to a few issues it was later reverted:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=e24b0bfa2f0446ffaad2661040be23668133aef8

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
