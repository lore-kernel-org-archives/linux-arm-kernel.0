From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Fri, 22 Apr 2016 22:26:57 +0100
Subject: [PATCH v3 0/9] EFI framebuffer support for ARM and arm64
In-Reply-To: <20160420190224.GC2829@codeblueprint.co.uk>
References: <1459526735-24936-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu_WPCbGgG1TjnY5tQ4YPgR_LDdaeR1fm-S=C894OsXiGQ@mail.gmail.com>
 <20160420190224.GC2829@codeblueprint.co.uk>
Message-ID: <20160422212656.GH2829@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Apr, at 08:02:24PM, Matt Fleming wrote:
> On Wed, 20 Apr, at 02:51:09PM, Ard Biesheuvel wrote:
> > 
> > Matt: FYI the memremap() patches for ARM that this series (and the
> > memory attributes one as well, for that matter) depends on have been
> > pulled by Russell and should turn up in -next shortly. That means
> > these patches are good to go, as far as I am concerned (unless there
> > are remaining concerns?)
> 
> Understood. I don't think there were any remaining concerns but I
> haven't reviewed the v3 series yet. I'll do that and get back to you.

OK, I've gone through this again. Everything looks very nice. It's
queued up for v4.7.
