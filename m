From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 20 Jun 2013 11:48:37 -0700
Subject: [PATCH 0/5] A handful of KVM/ARM fixes
In-Reply-To: <51C34CD8.4070609@arm.com>
References: <1371648006-8036-1-git-send-email-marc.zyngier@arm.com>
 <20130620183328.GF4563@lvm> <51C34CD8.4070609@arm.com>
Message-ID: <20130620184837.GG4563@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 07:41:28PM +0100, Marc Zyngier wrote:
> On 20/06/13 19:33, Christoffer Dall wrote:
> > On Wed, Jun 19, 2013 at 02:20:01PM +0100, Marc Zyngier wrote:
> >> This is a small patch series that I accumulated while tracking what
> >> turned out to be an unrelated issue.
> >>
> >> The first patch has already been posted a while ago and included here
> >> for completeness. The others are fairly simple missing barriers/clear
> >> exclusives that are actually required.
> >>
> >> This has been tested on TC2, and is also available in my tree:
> >> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm/fixes-3.10-rc6
> >>
> > Will you update the version with the specific options to the dsb's
> > pointed out by Will before I merge this?
> > 
> > I'd like to include it for the pull request to kvm/next, which I'm
> > planning on getting out tomorrow.
> 
> I was planning to do that tomorrow morning (UK time). Is that OK for you?
> 

Perfect, thanks.
