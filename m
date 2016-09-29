From: Vadim.Lomovtsev@caviumnetworks.com (Vadim Lomovtsev)
Date: Thu, 29 Sep 2016 01:09:04 -0700
Subject: [PATCH] arm64: set path to Image.gz in the mkspec to avoid rpm
 build issue
In-Reply-To: <9900a5d1-d133-12dc-0ff1-9370e6dab7a7@suse.com>
References: <1474991627-1743-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <20160928094913.GD24658@arm.com>
 <9900a5d1-d133-12dc-0ff1-9370e6dab7a7@suse.com>
Message-ID: <20160929080903.GA5421@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2016 at 09:23:51AM +0200, Michal Marek wrote:
> On 2016-09-28 11:49, Will Deacon wrote:
> > [Adding Michal Marek]
> > 
> > On Tue, Sep 27, 2016 at 08:53:47AM -0700, Vadim Lomovtsev wrote:
> >> In addition to http://www.spinics.net/lists/arm-kernel/msg527466.html
> >>
> >> While building rpm-pkg target it fails to copy kernel image
> >> from default location to rpm buildroot directory.
> >>
> >> Since we have arch variable set to aarch64 while Image.gz
> >> is located at arch/arm64/boot it's necessary to specify
> >> correct path to cp command as it implemeted for ppc64 build.
> 
> The variable should point to the actual file. ppc64 should be fixed as well.
> 
> Michal

Understood. Thanks for feed-back.

Vadim
