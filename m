From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 12 Feb 2015 22:51:25 +0300
Subject: [PATCH] ARM64:ftrace: fix ftrace_modify_graph_caller for branch
 replace
In-Reply-To: <b86ab19fb587cc7acc94a9b990afe0c33a073170.1423755113.git.panand@redhat.com>
References: <b86ab19fb587cc7acc94a9b990afe0c33a073170.1423755113.git.panand@redhat.com>
Message-ID: <54DD043D.8000801@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/12/2015 06:33 PM, Pratyush Anand wrote:

> ftrace_enable_ftrace_graph_caller and ftrace_disable_ftrace_graph_caller
> should replace B(jmp) instruction and not BL(call) instruction.

> patch 9f1ae7596aad71d18c3e88a3927f3f76b037b8fe did a typo and used

    s/patch/commit/. And please specify that commit's summary line in parens.

> AARCH64_INSN_BRANCH_LINK instead of AARCH64_INSN_BRANCH_NOLINK.

> Signed-off-by: Pratyush Anand <panand@redhat.com>

[...]

WBR, Sergei
