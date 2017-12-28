From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 28 Dec 2017 10:42:07 -0500
Subject: [PATCH v6 5/8] kernel: tracepoints: add support for relative
 references
In-Reply-To: <20171227085033.22389-6-ard.biesheuvel@linaro.org>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-6-ard.biesheuvel@linaro.org>
Message-ID: <20171228104207.117ee0ff@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Dec 2017 08:50:30 +0000
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> To avoid the need for relocating absolute references to tracepoint
> structures at boot time when running relocatable kernels (which may
> take a disproportionate amount of space), add the option to emit
> these tables as relative references instead.
> 

I gave this patch a quick skim over. It appears to not modify anything
when CONFIG_HAVE_PREL32_RELOCATIONS is not defined. I haven't
thoroughly reviewed it or tested it. But if it doesn't break anything,
I'm fine giving you an ack.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

--  Steve
