From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 May 2017 12:18:36 +0100
Subject: [PATCH v2] iommu/arm-smmu-v3: Increase CMDQ drain timeout value
In-Reply-To: <CA+sq2Cc_6Wj-0wLG=5fTAS66Tyn=63=An-Ay7h=EV=mjDi2-MQ@mail.gmail.com>
References: <1493983066-28202-1-git-send-email-sunil.kovvuri@gmail.com>
 <CA+sq2Cc_6Wj-0wLG=5fTAS66Tyn=63=An-Ay7h=EV=mjDi2-MQ@mail.gmail.com>
Message-ID: <20170530111835.GE32289@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sunil,

On Mon, May 29, 2017 at 02:41:59PM +0530, Sunil Kovvuri wrote:
> On Fri, May 5, 2017 at 4:47 PM,  <sunil.kovvuri@gmail.com> wrote:
> > From: Sunil Goutham <sgoutham@cavium.com>
> >
> > Processing queue full of TLB invalidation commands might
> > take more time on some platforms than current timeout
> > of 100us. So increased drain timeout value.
> >
> > Also now udelay time is increased exponentially for each poll.
> >
> > Signed-off-by: Sunil Goutham <sgoutham@cavium.com>

[...]

> Gentle reminder for patch review.

Sorry, I forgot to push this out. Should be on my iommu/devel branch now.

Will
