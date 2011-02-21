From: olof@lixom.net (Olof Johansson)
Date: Sun, 20 Feb 2011 20:26:49 -0800
Subject: [PATCH v2 19/21] ARM: tegra: clock: Add function to set SDMMC tap
	delay
In-Reply-To: <1298154371-5641-21-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<1298154371-5641-21-git-send-email-ccross@android.com>
Message-ID: <AANLkTin_eZemFBP5NirvHV8fDUemRHX3tSkb21=gZVme@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 19, 2011 at 2:26 PM, Colin Cross <ccross@android.com> wrote:
> The SDMMC controllers have extra bits in the clock source
> register that adjust the delay between the clock and data
> to compenstate for delays on the PCB. ?The values need to
> be set from the clock code so the clock can be locked
> during the read-modify-write on the clock source register.
>
> Signed-off-by: Colin Cross <ccross@android.com>

This is going in without any in-tree consumers of the functions.
Still, it'll likely be added shortly, so:

Acked-by: Olof Johansson <olof@lixom.net>

(If they don't show up, it'll be easy to drop it again if need be).



-Olof
