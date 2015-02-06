From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 6 Feb 2015 11:53:35 -0600
Subject: [PATCH v6 0/7] PCI: get DMA configuration from parent device
In-Reply-To: <54D4DD95.7000303@ti.com>
References: <1423173179-10227-1-git-send-email-m-karicheri2@ti.com>
 <20150206151542.GD23190@e104818-lin.cambridge.arm.com>
 <54D4DD95.7000303@ti.com>
Message-ID: <CAErSpo6GOXHeKKfU8s5jCS3+Mui=HupZd=jpkLEyWAE94Ory5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 6, 2015 at 9:28 AM, Murali Karicheri <m-karicheri2@ti.com> wrote:
> On 02/06/2015 10:15 AM, Catalin Marinas wrote:
>>
>> On Thu, Feb 05, 2015 at 09:52:52PM +0000, Murali Karicheri wrote:
>>>
>>> This patch add an important capability to PCI driver on Keystone. I hope
>>> to
>>> have this merged to the upstream branch so that it is available for
>>> v3.20.
>>
>> It's very late for 3.20 and the code hasn't been in linux-next at all
>> (but it's not me who's merging this code), unless you can squeeze it in
>> as a bug-fix.
>
> This is in fact a bug fix as PCI on Keystone is broken without this.

Oh, sorry, I didn't realize that this was so urgent.  I guess I read
"this adds an important capability" in the cover letter and concluded
that it was new functionality.

Anyway, if it's broken, presumably PCI on Keystone *did* work at one
point.  Can you identify the commit that broke it and requires these
fixes, so we can figure out how far the fixes need to be backported?

If I merge it, I would like to get into my for-linus branch and get a
little time in -next before asking Linus to pull it.  The merge window
is a little wrinkle there -- I don't like to add new things to the mix
during the window.  But if it's an important fix we can still get it
in before the final v3.20.

Bjorn
