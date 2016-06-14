From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Jun 2016 15:43:04 +0100
Subject: [PATCH] arm64: Implement arch_setup_pdev_archdata hook
In-Reply-To: <CAMz4kuJbqdmO=Uk07kWSnpg0+yGkzsZMWwNZdyMPH_-7svDdnQ@mail.gmail.com>
References: <b4645ade4a4d4150e76594f5bf04a3ad5e7d5221.1465287808.git.baolin.wang@linaro.org>
 <575690CB.5080501@arm.com>
 <CAMz4kuJbqdmO=Uk07kWSnpg0+yGkzsZMWwNZdyMPH_-7svDdnQ@mail.gmail.com>
Message-ID: <20160614144304.GD14654@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 05:22:25PM +0800, Baolin Wang wrote:
> On 7 June 2016 at 17:15, Robin Murphy <robin.murphy@arm.com> wrote:
> > Please elaborate on the situation that you're attempting to address here
> > (please don't let it be the ongoing Designware USB catastrophe ;))
> 
> Yes, like you mentioned, we met problems at DesignWare USB3 controller
> host glue, do you have any better solutions to solve this problem?

There has been a recent thread on this topic:

http://thread.gmane.org/gmane.linux.usb.general/140374

And a subsequent patch with another long discussion:

http://thread.gmane.org/gmane.linux.kernel/2207020

Please have a look, maybe you can make more sense of it ;). AFAICT,
there was no clear conclusion reached.

-- 
Catalin
