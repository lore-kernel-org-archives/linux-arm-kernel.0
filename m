From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Tue, 28 Jun 2016 16:31:15 +0900
Subject: [PATCH v14 00/10] arm64: Add kernel probes (kprobes) support
In-Reply-To: <1466996813-23295-1-git-send-email-dave.long@linaro.org>
References: <1466996813-23295-1-git-send-email-dave.long@linaro.org>
Message-ID: <20160628163115.57dba9bcff23adf9f8c8849c@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Sun, 26 Jun 2016 23:06:43 -0400
David Long <dave.long@linaro.org> wrote:

> From: "David A. Long" <dave.long@linaro.org>
> 
> This patchset is heavily based on Sandeepa Prabhu's ARM v8 kprobes patches,
> first seen in October 2013. This version attempts to address concerns
> raised by reviewers and also fixes problems discovered during testing.
> 
> This patchset adds support for kernel probes(kprobes), jump probes(jprobes)
> and return probes(kretprobes) support for ARM64.
> 
> The kprobes mechanism makes use of software breakpoint and single stepping
> support available in the ARM v8 kernel.

Great! All the patches in this series are OK for me :)
If you'd like to update the series about directory renaming and
including "asm-generic/ptrace.h", feel free to do so, and resend
with my Ack.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
for this series.

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
