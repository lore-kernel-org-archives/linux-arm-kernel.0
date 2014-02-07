From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 7 Feb 2014 09:50:17 +0000
Subject: [PATCH 2/2] ARM64: powernv: remove redundant cpuidle_idle_call()
In-Reply-To: <1391696188-14540-2-git-send-email-nicolas.pitre@linaro.org>
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
 <1391696188-14540-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <CAHkRjk7O4L9SaZVJqWxwbtpp6Qiy5ageQLa8hz4Wepe4LzagLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 February 2014 14:16, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> The core idle loop now takes care of it.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
