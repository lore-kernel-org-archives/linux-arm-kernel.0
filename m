From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 06 Aug 2013 13:28:50 -0600
Subject: [PATCH 2/2] ARM: tegra: use dt-binding header for key code
In-Reply-To: <1375798370-2231-2-git-send-email-ldewangan@nvidia.com>
References: <1375798370-2231-1-git-send-email-ldewangan@nvidia.com>
 <1375798370-2231-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <52014E72.2070604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2013 08:12 AM, Laxman Dewangan wrote:
> In place of hardcoding the key code in DTS file and comment the key code
> as side notes, use the key code macro defines in the dt-bindings/input/input.h
> directly.

This one also looks fine to me. I'll wait for an updated version that
converts everything once patch 1/2 is accepted/applied.
