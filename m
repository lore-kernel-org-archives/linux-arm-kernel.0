From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 05 Aug 2015 10:11:52 -0700
Subject: [PATCH] ARM: BCM: Enable ARM erratum 798181 for BRCMSTB
In-Reply-To: <1438739008-16718-1-git-send-email-gregory.0xf0@gmail.com>
References: <1438739008-16718-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <55C243D8.8050704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/15 18:43, Gregory Fong wrote:
> Commit 04fcab32d3fa1d3f6afe97e0ab431c5572e07a2c ("ARM: 8111/1: Enable
> erratum 798181 for Broadcom Brahma-B15") enables this erratum for
> affected Broadcom Brahma-B15 CPUs when CONFIG_ARM_ERRATA_798181=y.
> Let's make sure that config option is actually set.
> 
> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>

Applied, to soc/next, thanks!
-- 
Florian
