From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Oct 2018 11:27:16 +0100
Subject: [PATCHv3 0/6] atomics: generate atomic headers / instrument arm64
In-Reply-To: <20181008171523.rw34hyaqap2yb3py@lakrids.cambridge.arm.com>
References: <20180904104830.2975-1-mark.rutland@arm.com>
 <20181008171523.rw34hyaqap2yb3py@lakrids.cambridge.arm.com>
Message-ID: <20181019102715.GA14246@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ingo,

On Mon, Oct 08, 2018 at 06:15:24PM +0100, Mark Rutland wrote:
> On Tue, Sep 04, 2018 at 11:48:24AM +0100, Mark Rutland wrote:
> > As previously requested, this is a (trivial) rebase of the remaining generated
> > atomic patches atop of v4.19-rc2, avoiding any potential conflict with Peter's
> > ldsem atomic cleanup patch that got taken through the tty tree.
> > 
> > Are you still happy to pick this up? Full blurb below.
> 
> Ping!
> 
> Do you have any comments, or would you be happy to queue this?
> 
> I'm happy to resend come rc1, if you'd prefer?

It would be really nice to see this merged. Any chance we could get this
queued at -rc1 for 4.21, please? If not, what more needs to be done?

Cheers,

Will
