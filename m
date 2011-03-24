From: Ulrich.Weigand@de.ibm.com (Ulrich Weigand)
Date: Thu, 24 Mar 2011 15:57:15 +0100
Subject: RFC: ARM: Support for VFP/NEON registers in coredumps
In-Reply-To: <20110324141826.GA3810@arm.com>
References: <20110324141826.GA3810@arm.com>
Message-ID: <OF1A9833E7.A620B0FF-ONC125785D.004F4BC3-C125785D.0052255A@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Martin <dave.martin@linaro.org> wrote:

>  c) Create a new note type specially for this, and dump the
>     VFP/NEON regs in there.  This is closest to the model followed
>     by ptrace, where PTRACE_GETREGS, PTRACE_GETFPREGS and
>     PTRAGE_GETVFPREGS are all distinct.
