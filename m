From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Nov 2017 11:54:33 +0000
Subject: [PATCH v2 11/18] arm64: make mrs_s and msr_s macros work with LTO
In-Reply-To: <20171115213428.22559-12-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-12-samitolvanen@google.com>
Message-ID: <20171116115433.GG9361@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 01:34:21PM -0800, Sami Tolvanen wrote:
> From: Alex Matveev <alxmtvv@gmail.com>
> 
> Use UNDEFINE_MRS_S and UNDEFINE_MSR_S to define corresponding macros
> in-place and workaround gcc and clang limitations on redefining macros
> across different assembler blocks.

What limitations? Can you elaborate please? Is this a fix?

Will
