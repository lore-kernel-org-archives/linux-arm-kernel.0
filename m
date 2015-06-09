From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Jun 2015 16:29:59 +0100
Subject: [PATCH v2 1/2] ARM: Add cpu_resume_arm() for firmwares that
 resume in ARM state
In-Reply-To: <7htwuhsvs7.fsf@deeprootsystems.com>
References: <1433272378-8470-1-git-send-email-sboyd@codeaurora.org>
 <1433272378-8470-2-git-send-email-sboyd@codeaurora.org>
 <20150602234048.GA7557@n2100.arm.linux.org.uk>
 <20150603001120.GA4534@codeaurora.org>
 <7h3821ubpf.fsf@deeprootsystems.com>
 <55760B6D.7090302@codeaurora.org>
 <7htwuhsvs7.fsf@deeprootsystems.com>
Message-ID: <20150609152959.GG7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 03:03:04PM -0700, Kevin Hilman wrote:
> Stephen Boyd <sboyd@codeaurora.org> writes:
> > I'm happy to see it be applied by arm-soc maintainers directly given
> > that Russell said "the patch looks good to me". The commit text needs a
> > slight reword here though, so I can resubmit the patches to arm-soc if
> > you like.
> 
> Go ahead and respin/resubmit, and I can get them ready, but I'll wait
> for an official word or acked-by from Russell before taking them both
> through arm-soc.

I've suggested to Kevin that, as I have another patch outstanding for
arm-soc, that I take this one into that same branch and send Kevin a
pull for both patches.  (Esp. as I don't like sending single-patch
pull requests.  Having two patches solves my dilema!)

Stephen, if you can arrange for the patch to end up in the patch system
please...

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
