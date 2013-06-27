From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 27 Jun 2013 18:47:56 +0400
Subject: [PATCH] ARM: cpuidle: davinci: Fix target residency
In-Reply-To: <1372327012-13528-1-git-send-email-daniel.lezcano@linaro.org>
References: <1372327012-13528-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <51CC509C.6040804@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 27-06-2013 13:56, Daniel Lezcano wrote:

> The commit 19976c2a88d125aec16b9255c7197c297bbdd637 changed the target

    Please also specify the summary line of that commit in parens.

> residency to 100000, assuming this is a careless mistake.

> The same happened to the at91's cpuidle driver.

> Fix it by putting the initial value to 10000.

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

WBR, Sergei
