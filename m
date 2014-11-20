From: antonynpavlov@gmail.com (Antony Pavlov)
Date: Thu, 20 Nov 2014 18:33:05 +0400
Subject: Looking for good references for ARM driver development
In-Reply-To: <546CBFAC.9040906@free.fr>
References: <546C920A.7060800@free.fr> <546CB0EB.9080005@suse.de>
 <546CBFAC.9040906@free.fr>
Message-ID: <20141120183305.53af4ec99d746403b339aaf1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Nov 2014 17:05:00 +0100
Mason <mpeg.blue@free.fr> wrote:

> Hello Andreas,
> 
> On 19/11/2014 16:02, Andreas F?rber wrote:
> 
> > Am 19.11.2014 um 13:50 schrieb Mason:
> >
...
> > Since this appears to be about an ARM SoC according to your To list,
> > in general, you create a device tree binding, that binding is
> > registered within your platform/... driver code and referenced in the
> > device tree for SoC or board, and then your driver will automatically
> > be probed.
> 
> I know nothing about DT (aside from the Wikipedia entry).
> I'll take a closer look at Documentation/devicetree.
> Will that explain what platform/... is?
> 
> I see a drivers/platform folder, but nothing ARM-specific there?

There are very good presentations from Free Electrons:

  * http://free-electrons.com/pub/conferences/2013/elce/petazzoni-device-tree-dummies/petazzoni-device-tree-dummies.pdf
     ** see also http://www.youtube.com/watch?v=m_NyYEBxfn8
  * https://archive.fosdem.org/2013/schedule/event/arm_in_the_linux_kernel/attachments/slides/273/export/events/attachments/arm_in_the_linux_kernel/slides/273/arm_support_kernel.pdf

--?
Best regards,
? Antony Pavlov
