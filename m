From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 02 Jan 2013 14:08:27 -0700
Subject: [PATCH 2/2] ARM: tegra: moving the clock gating procedure to
 tegra_cpu_kill
In-Reply-To: <20121223121231.GA16580@mudshark.cambridge.arm.com>
References: <1355970519-28200-1-git-send-email-josephl@nvidia.com>
 <1355970519-28200-2-git-send-email-josephl@nvidia.com>
 <50D34467.9000006@wwwdotorg.org>
 <1356083897.26029.187.camel@jlo-ubuntu-64.nvidia.com>
 <50D4D345.6030804@wwwdotorg.org>
 <20121223112540.GF16237@mudshark.cambridge.arm.com>
 <20121223121231.GA16580@mudshark.cambridge.arm.com>
Message-ID: <50E4A1CB.7060601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/23/2012 05:12 AM, Will Deacon wrote:
... [kexec on ARM SMP discussion]
> The best bet is probably to call disable_nonboot_cpus in machine shutdown,
> before sending the stop and subsequent kill. It's very similar to your
> initial suggestion, but without the #elif.
> 
> Does that work for you?

Yes, it does. I just sent a patch implementing that. Thanks.
