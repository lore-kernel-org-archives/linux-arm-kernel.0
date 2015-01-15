From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 15 Jan 2015 10:25:11 -0700
Subject: [PATCH v2 02/11] ARM: tegra: Use the generated pinmux data
In-Reply-To: <1421338359-27467-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1421338359-27467-1-git-send-email-tomeu.vizoso@collabora.com>
 <1421338359-27467-3-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <54B7F7F7.1020202@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2015 09:12 AM, Tomeu Vizoso wrote:
> Google has submitted a board config for the pinmux programming of the
> Nyan Big board. Use the whole of it as it's generated to make it easier
> to update as the configuration gets fixed in the future.

Submitted to where? I assume you mean tegra-pinmux-scripts. I don't see 
a Nyan/Nyan-big configuration there yet. IIRC (and I might not) one was 
posted, but there were some review comments that aren't yet addressed?
