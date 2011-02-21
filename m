From: olof@lixom.net (Olof Johansson)
Date: Sun, 20 Feb 2011 20:07:52 -0800
Subject: [PATCH v2 04/21] ARM: tegra: clock: Don't use PLL lock bits
In-Reply-To: <1298154371-5641-6-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<1298154371-5641-6-git-send-email-ccross@android.com>
Message-ID: <AANLkTikWeiv-5cLFo3UG3yLpiPB3=YWQ+-2UV_vfROfF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 19, 2011 at 2:25 PM, Colin Cross <ccross@android.com> wrote:
> The PLL lock bits are not reliable, use per-PLL timeouts instead.
>
> Signed-off-by: Colin Cross <ccross@android.com>

Acked-by: Olof Johansson <olof@lixom.net>
