From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 Jan 2014 19:13:25 +0100
Subject: [PATCH v2 0/7] Allow MSM DT platforms to be built multi-platform
In-Reply-To: <1388438133-431-1-git-send-email-sboyd@codeaurora.org>
References: <1388438133-431-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <201401021913.25920.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 December 2013, Stephen Boyd wrote:
> These patches allow the DT based MSM platforms to be built as part of the
> multi-platform kernel. I need acks from Chris Ball on the mmc patch and
> Rob/Dave on the drm patch. I dropped Arnd's ack on patch 6 because I've
> rebased that patch on top of the patchset David sent out (which this is in
> reply to). The rebase was fairly minor and the new patch for drm/msm is
> trivial. Please consider for v3.14.

Just for the record, I'm definitely happy with the way this is turning out,
don't see my question on the serial driver as a NAK. I assume we will apply
the patches for 3.14, but I first want to have a better understanding on
where we are with the stuff that is already queued up for 3.14.

	Arnd
