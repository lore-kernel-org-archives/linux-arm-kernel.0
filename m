From: fschnizlein@suse.com (Felix Schnizlein)
Date: Tue, 26 Sep 2017 15:21:34 +0200
Subject: Unreviewed arm64 ABI change in linux-next via driver-core tree
In-Reply-To: <20170926131525.GE15480@leverpostej>
References: <20170926124536.GA11192@arm.com>
 <20170926131525.GE15480@leverpostej>
Message-ID: <20170926132134.6ekk44ezeehovppe@angmar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.09.17, Mark Rutland wrote:
> Hi,
> 
> On Tue, Sep 26, 2017 at 01:45:37PM +0100, Will Deacon wrote:
> > Hi Greg,
> > 
> > We stumbled over a change in linux-next that has ABI implications for arm64
> > and, as far as we can tell, has not been reviewed:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/arm64/kernel?id=fb7ff3f8721b87bf078868c9a252fa0cf71a47c2
> > 
> > ("fb7ff3f8721b cpuinfo: implement sysfs nodes for arm64")
> 
> > Please can you drop this from your tree until we've had a chance to review
> > it properly? If Felix can repost it as above, then we can get the discussion
> > started because, aside from this email, we have concerns about exactly what
> > is being exposed to userspace here.
> 
> Seconded.
> 
> Experience with the existing /proc/cpuinfo shows that this needs *very*
> careful review.
> 
> I've worked on arm64's /proc/cpuinfo, and I'd appreciate being Cc'd on
> future postings of this series. I'd also recommend that future postings
> are also Cc'd to linux-arch (and maybe linux-api) so that the interface
> is reviewed by a larger set of relevant parties.

I will do that!
> 
> Thanks,
> Mark.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/eaad4b39/attachment.sig>
