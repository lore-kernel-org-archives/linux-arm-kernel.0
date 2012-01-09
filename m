From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 9 Jan 2012 17:26:03 +0200
Subject: [PATCH v2 0/3] Tegra30 clockframework
In-Reply-To: <1326121937-32054-1-git-send-email-pdeschrijver@nvidia.com>
References: <1326121937-32054-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20120109152603.GV32619@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 04:12:10PM +0100, Peter De Schrijver wrote:
> This patchset introduces the tegra30 clockframework. Clocks which require
> voltage scaling are not included in this version. The implementation doesn't
> use the generic clock code yet. It's the intention to move to it, once the
> semantics are fully clarified.
> 
> ---
> 
> Changes in v2:
>  * Fix parent clocks for TWD. This makes the SMP configuration booting again.
> 
> Peter De Schrijver (3):
>   ARM: tegra: add support for new clock framework features
>   ARM: tegra: implement basic tegra30 clock framework
>   ARM: tegra: enable tegra30 clock framework

Oops. Now I sent everything twice... Will send it again with the correct
topic etc.

Cheers,

Peter.
