From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 9 Jan 2014 11:48:00 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <1389208330-12495-1-git-send-email-broonie@kernel.org>
References: <1389208330-12495-1-git-send-email-broonie@kernel.org>
Message-ID: <20140109114759.GG3081@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 07:12:07PM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Add basic CPU topology support to arm64, based on the existing pre-v8
> code and some work done by Mark Hambleton.  This patch does not
> implement any topology discovery support since that should be based on
> information from firmware, it merely implements the scaffolding for
> integration of topology support in the architecture.

Mark, for future patches, could you please add a cover letter with a
simple changelog and also add some versioning to the subject ([PATCH v*]).
It's getting hard to follow which series addresses what comments,
especially when you post more updates in the same day.

Thanks.

-- 
Catalin
