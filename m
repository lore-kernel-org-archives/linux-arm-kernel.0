From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  4 Jun 2018 14:12:39 -0700
Subject: [PATCH v2 2/2] ARM: debug: fix BCM2836 order entry
In-Reply-To: <20180530131956.13972-2-peron.clem@gmail.com>
References: <20180530131956.13972-1-peron.clem@gmail.com>
 <20180530131956.13972-2-peron.clem@gmail.com>
Message-ID: <20180604211239.20528-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 May 2018 15:19:56 +0200, Cl?ment P?ron <peron.clem@gmail.com> wrote:
> From: Cl?ment Peron <clement.peron@devialet.com>
> 
> Entries are sorted by their address value, except the BCM2836/KONA
> which are not in the proper order.
> 
> Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
> ---

Applied to soc/next, thanks!
--
Florian
