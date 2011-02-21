From: olof@lixom.net (Olof Johansson)
Date: Sun, 20 Feb 2011 20:17:28 -0800
Subject: [PATCH v2 13/21] ARM: tegra: clock: Remove unnecessary uses of
	#ifdef CONFIG_DEBUG_FS
In-Reply-To: <1298154371-5641-15-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<1298154371-5641-15-git-send-email-ccross@android.com>
Message-ID: <AANLkTimHrMZAfxx-N+Ub7_cjtwJC2s0KsnUPHw4Z7B7o@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 19, 2011 at 2:26 PM, Colin Cross <ccross@android.com> wrote:
> Signed-off-by: Colin Cross <ccross@android.com>

Technically, this patch does not _just_ "remove unneccessary uses of #ifdef".

I'd say "tegra: clock: minor cleanups" as patch subject, and:
* Remove unneccessary uses of #ifdef CONFIG_DEBUG_FS
* "1" -> "true" for some bool assigments

as patch description.

With that fixed:

Acked-by: Olof Johansson <olof@lixom.net>
