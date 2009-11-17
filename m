From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 17 Nov 2009 13:01:18 +0000
Subject: [PATCH] drivers: MMC: enable SDHCI-S3C on S5PC1XX platform
In-Reply-To: <20091117121143.09246257@life-in-the-fast-lane>
References: <1258444374-21479-1-git-send-email-m.szyprowski@samsung.com>
	<20091117121143.09246257@life-in-the-fast-lane>
Message-ID: <20091117130116.GY23772@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2009 at 12:11:43PM +0100, Marc Zyngier wrote:
> On Tue, 17 Nov 2009 08:52:54 +0100
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> 
> I think it was Ben that suggested once to introduce a HAVE_SDHCI_S3C
> symbol, selected by interested parties (S3C, S5P, S5PC...).

Yes, I did mention this and it is an option to either replace the patch
now or to do at a later date to tidy things up. I'm not going to reject
this patch now (or force a rewrite at this late stage)

I'll try and look at acking the last set of SDHCI patches Thomas sent
and see if akpm will pick them up for linux-mmc.

> Given the way Samsung SoCs are assembled (from an IP point of view), it
> would make sense for one SoC to describe its features in
> "HAVE_FEATURE_FOO" terms rather than each subsystem depending an ever
> growing list of SoC.

Yes, I was feeling that this is something that we should probably discuss
either on linux-arm-kernel or to a wide audience. It might not suit
everyone's taste, etc.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
