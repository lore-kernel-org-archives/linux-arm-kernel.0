From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 3 Jul 2012 10:13:32 -0300
Subject: Clock problems in i.MX27 Visstrim M10 (linux-3.5-rc5).
In-Reply-To: <CACKLOr0z13sMQhb14YpDp7UtwfhVoqRAMOJCA+geapq=Lh7VuQ@mail.gmail.com>
References: <CACKLOr0z13sMQhb14YpDp7UtwfhVoqRAMOJCA+geapq=Lh7VuQ@mail.gmail.com>
Message-ID: <CAOMZO5CeGKJ6kERaCkNE0Cpy2X78CUN_-au5Q+cCtLLjtNXMDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Tue, Jul 3, 2012 at 8:09 AM, javier Martin
<javier.martin@vista-silicon.com> wrote:
> Hi,
> I've found the following problems in linux-3.5-rc5
> (6887a4131da3adaab011613776d865f4bcfb5678) in our Visstrim M10 board:

Could you please try the two attached patches?

They should fix the dma and mx2-camera issues.

I will try to look at the ssi problem, but my mx27pdk board still does
not have audio supported.

Regards,

Fabio Estevam
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-clkdma.patch
Type: application/octet-stream
Size: 2637 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120703/b546b6ff/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-clkmx2cam.patch
Type: application/octet-stream
Size: 3983 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120703/b546b6ff/attachment-0003.obj>
