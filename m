From: olof@lixom.net (Olof Johansson)
Date: Sun, 20 Feb 2011 20:08:25 -0800
Subject: [PATCH v2 06/21] ARM: tegra: clock: Initialize clocks that have
	no enable
In-Reply-To: <1298154371-5641-8-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<1298154371-5641-8-git-send-email-ccross@android.com>
Message-ID: <AANLkTik7rwOTKPvL3H_j7Mxa-4h5G9423360grTgLCR+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 19, 2011 at 2:25 PM, Colin Cross <ccross@android.com> wrote:
> Assume that any clock that has no enable op is always on.
>
> Signed-off-by: Colin Cross <ccross@android.com>

Acked-by: Olof Johansson <olof@lixom.net>
