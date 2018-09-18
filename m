From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Sep 2018 09:38:05 +0100
Subject: [PATCH RESEND 3/6] arm64: add sysfs vulnerability show for
 spectre v1
In-Reply-To: <20180917172206.GA3795@rric.localdomain>
References: <20180827143310.641-1-ykaukab@suse.de>
 <20180827143310.641-4-ykaukab@suse.de>
 <20180917172206.GA3795@rric.localdomain>
Message-ID: <20180918083805.GB14404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 07:22:07PM +0200, Robert Richter wrote:
> On 27.08.18 16:33:07, Mian Yousaf Kaukab wrote:
> > Hard-coded since patches are merged and there are no configuration
> > options.
> 
> Could you add a list of upstream patches to the description that are
> required to solve this? This would be a strict definition for the
> mitigation being enabled and makes it easier to check if backports are
> affected or not. A build-time check would be ideal (e.g. checking for
> certain macros).

Hmm, I don't grok what you're proposing here. Why do we need a build-time
check (and to check what?)

Confused,

Will
