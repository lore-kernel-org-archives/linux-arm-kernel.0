From: dsd@laptop.org (Daniel Drake)
Date: Sun, 15 Jul 2012 15:49:03 -0600
Subject: Losing VFP registers over suspend/resume
In-Reply-To: <CAMLZHHTvogPv06zukuUTuc6ezLuoMDwNSy6nPS_q=ambadi8VQ@mail.gmail.com>
References: <CAMLZHHTvogPv06zukuUTuc6ezLuoMDwNSy6nPS_q=ambadi8VQ@mail.gmail.com>
Message-ID: <CAMLZHHSgOehpKv56Osccueb+xYt36J0S54Na8D0eqdCkxMzhTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 14, 2012 at 10:49 PM, Daniel Drake <dsd@laptop.org> wrote:
> Applying the patch "ARM: vfp: Always save VFP state in vfp_pm_suspend"
> solves the issue.
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/042048.html
> I tested with the above test case for several hours, and another OLPC
> developer verified. No more bad calculations, no more crashes.
>
> Any chance this effort could be revived? Looks like the patch was almost acked:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/042930.html

That was an old patch. We think the latest one is here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-May/051091.html

This no longer applies due to last_VFP_context being renamed. I'll
send a v5 patch now to fix that.

Thanks
Daniel
