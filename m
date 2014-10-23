From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 23 Oct 2014 11:12:30 +0300
Subject: [PATCH v1 1/5] mfd: tps65910: Convert ti, system-power-controller
 DT property to poweroff-source
In-Reply-To: <1413991587-11110-1-git-send-email-romain.perier@gmail.com>
References: <1413991587-11110-1-git-send-email-romain.perier@gmail.com>
Message-ID: <20141023081230.GK32045@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 03:26:23PM +0000, Romain Perier wrote:
> No longer use custom property to define poweroff capability, use the standard
> DT property instead.
> 

This breaks DT ABI stability right? An existing device tree using ti,system-power-controller won't work anymore after this patch right? I don't think that's acceptable.

CHeers,

Peter.
