From: broonie@kernel.org (Mark Brown)
Date: Tue, 2 Jun 2015 19:20:59 +0100
Subject: [PATCH 0/6] Support CPR on MSM8916
In-Reply-To: <20150602175654.GA24349@codeaurora.org>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
 <20150602105328.GJ14071@sirena.org.uk>
 <20150602175654.GA24349@codeaurora.org>
Message-ID: <20150602182059.GD14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 10:56:54AM -0700, Stephen Boyd wrote:
> On 06/02, Mark Brown wrote:

> > These two patches don't seem to be tied to the rest of the series at all
> > (they certainly trigger already for some systems).

> The series causes these warning to trigger on devices with CPR
> and these patches silence them. So it is related, but the patches
> aren't necessary for compilation. They should go through the
> regulator tree, if that's what you're asking.

I wasn't really asking, more saying that they should not have been sent
in the same series, especially not a series listing such a complicated
set of external dependencies.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150602/b00ad5b1/attachment.sig>
