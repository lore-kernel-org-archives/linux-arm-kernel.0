From: JOLLYS@xilinx.com (Jolly Shah)
Date: Mon, 10 Sep 2018 20:39:33 +0000
Subject: [GIT PULL] arm64: zynqmp: Xilinx SoC changes for v4.20
In-Reply-To: <CAOesGMjh-Chhncw3cYaCvFpfhtOSz8hprC0xARmVXe8i4mvxHw@mail.gmail.com>
References: <5e9c248d-c19c-1881-f406-d7bfd38ec479@xilinx.com>
 <CAOesGMjh-Chhncw3cYaCvFpfhtOSz8hprC0xARmVXe8i4mvxHw@mail.gmail.com>
Message-ID: <CY1PR02MB2138F7D3AACB11CAA959B496B8050@CY1PR02MB2138.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

> -----Original Message-----
> From: Olof Johansson [mailto:olof at lixom.net]
> Sent: Saturday, September 08, 2018 6:22 PM
> To: Michal Simek <michals@xilinx.com>
> Cc: arm-soc <arm@kernel.org>; Jolly Shah <JOLLYS@xilinx.com>; linux-arm
> <linux-arm-kernel@lists.infradead.org>
> Subject: Re: [GIT PULL] arm64: zynqmp: Xilinx SoC changes for v4.20
> 
> Hi Michal,
> 
> On Fri, Sep 7, 2018 at 12:57 AM, Michal Simek <michal.simek@xilinx.com>
> wrote:
> > Hi,
> >
> > please pull the following firmware interface to your tree.
> >
> > Thanks,
> > Michal
> >
> >
> > The following changes since commit
> 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> >
> >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> >
> > are available in the git repository at:
> >
> >   https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-soc-for-v4.20
> >
> > for you to fetch changes up to
> bca7067d2d4e91f58162b07d73cd94e20437b4f6:
> >
> >   firmware: xilinx: Add debugfs for query data API (2018-09-07
> > 09:44:44
> > +0200)
> >
> > ----------------------------------------------------------------
> > arm64: zynqmp: SoC changes for v4.20
> >
> > - Adding firmware API for SoC with debugfs interface
> 
> This is a bit terse. Jolly has been good at writing cover letters, you could have
> stolen the writeup from there. :)
> 
> I posted two comments on the patches -- one is a nit that can be followed up on
> with an incremental patch.
> 

Posted incremental patch set to address your review comments. Also included a commit from v11 which was missed in above pull request.


> I'm more worried about the ioctl interface though, and what it opens up. Maybe
> it's been discussed in the time the set has been reviewed, I didn't search
> extensively for the history. If it had been, bringing explanations into the patch
> description would have been nice for new readers such as myself. And if it
> hasn't, well, let's talk about it.
> 

Responded to your queries in another thread. Will be happy to answer any further questions you have.

Thanks,
Jolly Shah

> Not merging based on the above. Hopefully it's something we can straighten out
> pretty quickly.
> 
> 
> -Olof
