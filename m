From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Sun, 15 Jan 2012 01:53:39 +0400
Subject: [PATCH] ARM: pl330: fix null pointer dereference in
 pl330_chan_ctrl()
In-Reply-To: <1326458191-23492-1-git-send-email-mans.rullgard@linaro.org>
References: <1326458191-23492-1-git-send-email-mans.rullgard@linaro.org>
Message-ID: <4F11F963.4050900@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 13-01-2012 16:36, Mans Rullgard wrote:

> This fixes the thrd->req_running field being accessed before thrd
> is checked for null.  The error was introduced in abb959f.

    Please also specify summary of that commit in parens.

> Signed-off-by: Mans Rullgard<mans.rullgard@linaro.org>

WBR, Sergei
